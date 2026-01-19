Running **multiple charts in Snowflake (Snowsight dashboards)** can feel slow because each chart often triggers **its own query execution** against the warehouse. When several charts run at once, you’re effectively asking Snowflake to do a lot of work in parallel. Here’s a clear breakdown of **why it’s slow** and **how to fix it**, with Snowflake-specific best practices.

---

## Why multiple charts take a long time

### 1. Each chart = separate query

* Even if charts look similar, **Snowflake does not automatically share results**
* 10 charts → 10 queries → 10 scans
* If they hit the same large table, that’s repeated I/O

---

### 2. Warehouse resource contention

* Dashboards usually run **simultaneously**
* A single warehouse has limited compute slots
* Queries queue or slow down when concurrency increases

**Symptoms**

* Charts load one by one
* Some say “Running…” for a long time

---

### 3. Large table scans (no pruning)

Common causes:

* No filter on date
* No clustering on frequently filtered columns
* Using `SELECT *`
* Filters applied **after aggregation**

Snowflake is fast, but **full table scans still cost time**

---

### 4. Inefficient SQL in charts

Typical dashboard anti-patterns:

* Repeated `COUNT(DISTINCT …)`
* Nested subqueries per chart
* Window functions recalculated per visualization
* Heavy joins inside each chart query

---

### 5. No result caching usage

Snowflake’s **Result Cache** is extremely fast, but it’s bypassed when:

* Queries differ slightly (even whitespace or aliases)
* Non-deterministic functions are used (`CURRENT_DATE`, `RANDOM`)
* Data has recently changed

---

### 6. Dashboard auto-refresh

* Each refresh reruns **all queries**
* Multiple users opening the dashboard = repeated executions

---

## How to reduce dashboard runtime (Best Practices)

### 1. Use a **base dataset query** (MOST IMPORTANT)

Instead of each chart querying raw tables:

```sql
CREATE OR REPLACE TABLE dashboard_base AS
SELECT
    txn_date,
    banner_key,
    SUM(total_count) AS total_count,
    SUM(revenue) AS revenue
FROM fact_table
WHERE txn_date >= DATEADD(month, -6, CURRENT_DATE)
GROUP BY 1,2;
```

Then **all charts query this table**, not the raw fact table.

✅ Massive performance gain
✅ Less compute
✅ More consistent metrics

---

### 2. Use **materialized views** for heavy logic

If you have:

* Joins
* Aggregations
* Filters that rarely change

```sql
CREATE MATERIALIZED VIEW mv_dashboard_metrics AS
SELECT ...
```

Snowflake keeps it updated automatically.

---

### 3. Reduce warehouse contention

Options:

* Use a **larger warehouse** for dashboards
* Enable **multi-cluster warehouse**

```sql
MIN_CLUSTER_COUNT = 1
MAX_CLUSTER_COUNT = 3
```

* Separate:

  * **ETL warehouse**
  * **Dashboard/BI warehouse**

---

### 4. Design charts to share filters

* Use dashboard-level filters (date, banner)
* Avoid hardcoded filters per chart
* Identical queries → result cache reuse

---

### 5. Avoid recalculating the same logic

Bad:

```sql
COUNT(DISTINCT user_id)
```

Better:

* Pre-aggregate once
* Store in intermediate table/view

---

### 6. Limit data early

Always filter ASAP:

```sql
WHERE txn_week >= DATEADD(week, -12, CURRENT_DATE)
```

Avoid:

```sql
SELECT *
```

---

### 7. Cluster tables for dashboard filters

If charts frequently filter by:

* `txn_date`
* `banner_key`

```sql
ALTER TABLE fact_table CLUSTER BY (txn_date, banner_key);
```

This helps **micro-partition pruning**.

---

### 8. Leverage Result Cache

To benefit:

* Keep SQL text **identical**
* Avoid `CURRENT_TIMESTAMP`
* Use bind variables or dashboard filters

Cached results return in **milliseconds** ⚡

---

### 9. Turn off unnecessary auto-refresh

* Refresh only when needed
* Stagger refresh times for multiple users

---

### 10. Measure before optimizing

Use:

```sql
QUERY_HISTORY
WAREHOUSE_LOAD_HISTORY
QUERY_PROFILE
```

Look for:

* Long execution time
* Large scanned bytes
* High queuing time

---

## Quick checklist (TL;DR)

✔ One base table/view for all charts
✔ Avoid raw fact tables in dashboards
✔ Use materialized views for heavy logic
✔ Multi-cluster warehouse for concurrency
✔ Filter early, avoid `SELECT *`
✔ Cluster on filter columns
✔ Share filters to reuse cache

---

If you want, I can:

* Review a **real dashboard query**
* Help you redesign it into a **single base dataset**
* Suggest **warehouse sizing** based on chart count

Just paste one of your chart queries 👇
