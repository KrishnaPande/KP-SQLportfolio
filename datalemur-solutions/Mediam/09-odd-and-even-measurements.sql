-- Assume you're given a table with measurement values obtained from a Google sensor over multiple days with measurements taken multiple times within each day.

-- Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day and display the results in two different columns. Refer to the Example Output below for the desired format.

-- Definition:

-- Within a day, measurements taken at 1st, 3rd, and 5th times are considered odd-numbered measurements, and measurements taken at 2nd, 4th, and 6th times are considered even-numbered measurements.


-- My Solution: Its not matching with solution
WITH cte AS (
    SELECT
        DATE_TRUNC('day', measurement_time) AS measurement_day,
        ROW_NUMBER() OVER (PARTITION BY DATE_TRUNC('day', measurement_time)) AS r,
        measurement_value
    FROM measurements
    ORDER BY measurement_day
),
cte2 AS (
    SELECT
        measurement_day,
        measurement_value,
        CASE WHEN r % 2 = 0 THEN 'even' ELSE 'odd' END AS type
    FROM cte
)
SELECT
    measurement_day,
    SUM(CASE WHEN type = 'odd' THEN measurement_value ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN type = 'even' THEN measurement_value ELSE 0 END) AS even_sum
FROM cte2
GROUP BY measurement_day;

-- Solution 2: Still Not Matching but hear we dont need cte2

WITH cte AS (
    SELECT
        DATE_TRUNC('day', measurement_time) AS measurement_day,
        ROW_NUMBER() OVER (PARTITION BY DATE_TRUNC('day', measurement_time)) AS r,
        measurement_value
    FROM measurements
    ORDER BY measurement_day
)

SELECT
        measurement_day,
        SUM(CASE WHEN r % 2 = 1 THEN measurement_value ELSE 0 END) AS odd_sum,
        SUM(CASE WHEN r % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM cte
GROUP BY 1

-- Actual correct Solution

WITH ranked_measurements AS (
  SELECT
    CAST(measurement_time AS DATE) AS measurement_day,
    measurement_value,
    ROW_NUMBER() OVER (
      PARTITION BY CAST(measurement_time AS DATE)
      ORDER BY measurement_time) AS measurement_num
  FROM measurements
)

SELECT
  measurement_day,
  SUM(measurement_value) FILTER (WHERE measurement_num % 2 != 0) AS odd_sum,
  SUM(measurement_value) FILTER (WHERE measurement_num % 2 = 0) AS even_sum
FROM ranked_measurements
GROUP BY measurement_day;