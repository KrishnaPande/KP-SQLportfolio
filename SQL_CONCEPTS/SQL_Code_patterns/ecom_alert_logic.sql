
WITH date AS
(
  SELECT date,
  row_number() OVER (ORDER BY date DESC) AS most_recent
  FROM infoscout.us_tlog.d_date AS dt
  -- Just a date table with all the date info, Quarter, month, week, year_week, day_of_year
  WHERE
  DATE < dateadd(DAY, -14, date_trunc('day', Current_date()))
    AND
  DATE >= dateadd(DAY, -(14 + 3), date_trunc('day', Current_date()))
),
base AS
(
  SELECT * FROM
  date AS d
  INNER JOIN
  (SELECT
     email_DATETIME,
    BANNER_KEY,
    STATE,
     id, 'EMAIL' AS table_source
  FROM
    INFOSCOUT.PRICESCOUT.RDL_ERECEIPT
  WHERE banner_key NOT IN ('amazoncom','krogercom')
  GROUP BY 1,2,3,4,5
  UNION ALL
  SELECT
    TRANSACTION_DATETIME AS EMAIL_DATETIME,
    BANNER_KEY,
    STATE,
    id,'LINK' AS table_source
  FROM
    INFOSCOUT.PRICESCOUT.RDL_ECOMMERECEIPT
  GROUP BY 1,2,3,4,5
  ) b
  ON d.date=date(b.email_datetime)
),
-- creating schema view as there might be missing dates for which data is zero
schma AS
(
  SELECT * FROM
    (SELECT banner_key,state,table_source
    FROM base
    GROUP BY banner_key,state,table_source)
  CROSS JOIN
    date
),

day_counts AS
(
      SELECT
        s.BANNER_KEY AS banner,
        s.state,
        s.table_source,
        s.date AS email_dt,
        s.most_recent,
        (CASE WHEN banner IN(SELECT DISTINCT banner_id FROM INFOSCOUT.US_TLOG.D_BANNER WHERE ECOMMERCE_TIER = 1) THEN TRUE ELSE FALSE END) AS tier_1,
        coalesce(count(id),0) AS number_of_emails
        FROM
          schma AS s
        LEFT JOIN
          base AS e
        ON s.date=e.date
        AND s.banner_key=e.banner_key
        AND s.state=e.state
        AND S.table_source=e.table_source
       GROUP BY 1,2,3,4,5
),
ecomm_monitoring_base as (SELECT   *,
    current_date() AS log_date,
    sum(number_of_emails) over(PARTITION BY banner,email_dt) AS total_number_of_emails,
    (CASE
    WHEN total_number_of_emails > 0
    THEN number_of_emails / total_number_of_emails
    ELSE 0
     END) AS percent,
    round(percent*100,0) AS percent_z
   FROM day_counts),

processing_baseline AS (
  -- Get historical baselines by processing state
  SELECT
    banner,
    state,
    table_source,  -- 'complete', 'error', 'summary'
    DAYOFWEEK(log_date) as dow,

    -- Volume baselines (email count)
    AVG(number_of_emails) as avg_email_volume,
    STDDEV(number_of_emails) as std_email_volume,
    PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY number_of_emails) as p5_email_volume,
    PERCENTILE_CONT(0.10) WITHIN GROUP (ORDER BY number_of_emails) as p10_email_volume,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY number_of_emails) as p95_email_volume,

    -- Processing rate baselines (percent in this state)
    AVG(percent) as avg_percent_in_state,
    STDDEV(percent) as std_percent_in_state,
    PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY percent) as p5_percent,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY percent) as p95_percent,

    -- Data quality
    COUNT(*) as sample_size,
    COUNT(CASE WHEN number_of_emails = 0 THEN 1 END) as zero_volume_days

  FROM ecomm_monitoring_base
  WHERE log_date BETWEEN CURRENT_DATE() - 56 AND CURRENT_DATE() - 1  -- 8 weeks
    AND DAYOFWEEK(log_date) = DAYOFWEEK(CURRENT_DATE())  -- Same day of week
    AND most_recent > 1
  GROUP BY banner, state, table_source, DAYOFWEEK(log_date)
  HAVING COUNT(*) >= 4  -- Minimum 4 weeks of data
),

current_state_summary AS (
  -- Aggregate current day processing state distribution
  SELECT
    banner,
    state,
    SUM(CASE WHEN table_source = 'complete' THEN number_of_emails ELSE 0 END) as complete_volume,
    SUM(CASE WHEN table_source = 'error' THEN number_of_emails ELSE 0 END) as error_volume,
    SUM(CASE WHEN table_source = 'summary' THEN number_of_emails ELSE 0 END) as summary_volume,
    SUM(number_of_emails) as total_volume,

    -- Processing health ratios
    CASE WHEN SUM(number_of_emails) > 0 THEN
      SUM(CASE WHEN table_source = 'complete' THEN number_of_emails ELSE 0 END) * 100.0 / SUM(number_of_emails)
    END as complete_rate,

    CASE WHEN SUM(number_of_emails) > 0 THEN
      SUM(CASE WHEN table_source = 'error' THEN number_of_emails ELSE 0 END) * 100.0 / SUM(number_of_emails)
    END as error_rate,

    CASE WHEN SUM(number_of_emails) > 0 THEN
      SUM(CASE WHEN table_source = 'summary' THEN number_of_emails ELSE 0 END) * 100.0 / SUM(number_of_emails)
    END as summary_rate

  FROM ecomm_monitoring_base
  WHERE log_date = CURRENT_DATE() AND most_recent = 1
  GROUP BY banner, state
),

historical_health AS (
  -- Historical processing health by banner/state
  SELECT
    banner, state,
    AVG(CASE WHEN table_source = 'complete' THEN percent ELSE 0 END) as avg_complete_rate,
    AVG(CASE WHEN table_source = 'error' THEN percent ELSE 0 END) as avg_error_rate,
    AVG(CASE WHEN table_source = 'summary' THEN percent ELSE 0 END) as avg_summary_rate,

    STDDEV(CASE WHEN table_source = 'complete' THEN percent ELSE 0 END) as std_complete_rate,
    STDDEV(CASE WHEN table_source = 'error' THEN percent ELSE 0 END) as std_error_rate,

    -- Total volume baselines
    SUM(CASE WHEN table_source = 'complete' THEN avg_email_volume ELSE 0 END) as avg_total_volume,
    SQRT(SUM(CASE WHEN table_source = 'complete' THEN POWER(std_email_volume,2) ELSE 0 END)) as std_total_volume

  FROM processing_baseline
  GROUP BY banner, state
)

SELECT
  -- Basic information
  d.log_date,
  d.banner,
  d.state,
  d.table_source,
  d.email_dt,
  d.percent as current_percent_in_state,
  d.number_of_emails as current_email_volume,
  d.tier_1,

  -- Baseline comparisons
  h.avg_email_volume,
  h.std_email_volume,
  h.avg_percent_in_state,
  h.sample_size,

  -- Volume anomaly detection
  CASE WHEN h.std_email_volume > 0 THEN
    (d.number_of_emails - h.avg_email_volume) / h.std_email_volume
  END as volume_zscore,

  CASE
    WHEN h.sample_size < 4 THEN 'insufficient-data'
    WHEN d.number_of_emails = 0 THEN 'no-volume-critical'
    WHEN d.number_of_emails < h.p5_email_volume THEN 'volume-drop-critical'
    WHEN d.number_of_emails < h.p10_email_volume THEN 'volume-drop-warning'
    WHEN d.number_of_emails > h.p95_email_volume THEN 'volume-spike-warning'
    ELSE 'volume-normal'
  END as volume_alert,

  -- Processing state anomaly detection
  CASE WHEN h.std_percent_in_state > 0 THEN
    (d.percent - h. avg_percent_in_state) / h.std_percent_in_state
  END as state_percent_zscore,

  CASE
    WHEN d.table_source = 'error' AND d.percent > h.p95_percent THEN 'high-error-rate-critical'
    WHEN d.table_source = 'error' AND d.percent > h.avg_percent_in_state + h.std_percent_in_state THEN 'high-error-rate-warning'
    WHEN d.table_source = 'summary' AND d.percent > h.p95_percent THEN 'high-summary-rate-warning'
    WHEN d.table_source = 'complete' AND d.percent < h.p5_percent THEN 'low-completion-rate-critical'
    WHEN d.table_source = 'complete' AND d.percent < h.avg_percent_in_state - h.std_percent_in_state THEN 'low-completion-rate-warning'
    ELSE 'processing-normal'
  END as processing_state_alert,

  -- Overall processing health (from summary table)
  s.total_volume,
  s.complete_rate,
  s.error_rate,
  s.summary_rate,
  hh.avg_complete_rate,
  hh.avg_error_rate,

  -- Business-critical combined alerts
  CASE
    -- Critical:  No receipts or very high error rate
    WHEN s.total_volume = 0 THEN 'critical-no-receipts'
    WHEN s. error_rate > 20 THEN 'critical-high-error-rate'
    WHEN s.complete_rate < 50 THEN 'critical-low-completion-rate'

    -- Warning:  Moderate issues
    WHEN s.total_volume < hh.avg_total_volume * 0.7 THEN 'warning-volume-drop'
    WHEN s.error_rate > hh.avg_error_rate + 5 THEN 'warning-elevated-errors'
    WHEN s.complete_rate < hh.avg_complete_rate - 10 THEN 'warning-reduced-completion'
    WHEN s.summary_rate > 30 THEN 'warning-high-summary-backlog'

    ELSE 'healthy'
  END as overall_receipt_health,

  -- Data quality indicators
  CASE
    WHEN h.zero_volume_days > h.sample_size * 0.2 THEN 'frequent-zero-volume-days'
    ELSE 'data-quality-ok'
  END as data_quality_flag,

  CURRENT_TIMESTAMP() as calculated_at

FROM ecomm_monitoring_base d t
LEFT JOIN processing_baseline h
  ON h.banner = d.banner
  AND h.state = d.state
  AND h.table_source = d.table_source
  AND h.dow = DAYOFWEEK(d.log_date)
LEFT JOIN current_state_summary s
  ON s.banner = d.banner AND s.state = d.state
LEFT JOIN historical_health hh
  ON hh.banner = d. banner AND hh.state = d.state
WHERE d.log_date = CURRENT_DATE()
  AND d.most_recent = 1;


--- ITs a wrong code but can be used how code is build and how cte are made what parameters are used inside and how thay are used