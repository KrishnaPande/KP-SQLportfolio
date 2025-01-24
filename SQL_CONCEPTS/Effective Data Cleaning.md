# SQL Techniques for Effective Data Cleaning

## 1. Remove Duplicate Records
Use `DISTINCT` or `ROW_NUMBER()` to identify and remove duplicate entries.

```sql
-- Remove duplicates using ROW_NUMBER()
WITH RankedData AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY column_to_check ORDER BY column_to_sort) AS row_num
    FROM table_name
)
DELETE FROM table_name
WHERE id IN (SELECT id FROM RankedData WHERE row_num > 1);
```

---

## 2. Handle Missing Data
- Identify missing values:
  ```sql
  SELECT * FROM table_name WHERE column_name IS NULL;
  ```
- Replace with default values or calculated values:
  ```sql
  UPDATE table_name
  SET column_name = 'default_value'
  WHERE column_name IS NULL;
  ```
- Remove rows with excessive missing values:
  ```sql
  DELETE FROM table_name WHERE column_name IS NULL AND another_column IS NULL;
  ```

---

## 3. Standardize Data Formats
Ensure consistency in date, text, or numeric formats.

- Standardize dates:
  ```sql
  UPDATE table_name
  SET date_column = TO_DATE(date_column, 'YYYY-MM-DD');
  ```
- Standardize text (e.g., lowercase):
  ```sql
  UPDATE table_name
  SET text_column = LOWER(text_column);
  ```

---

## 4. Remove Outliers
Use statistical methods or predefined ranges to filter out data points.

```sql
DELETE FROM table_name
WHERE column_name < lower_limit OR column_name > upper_limit;
```

---

## 5. Trim Whitespace and Unwanted Characters
Use `TRIM`, `LTRIM`, `RTRIM`, or `REPLACE` to clean text data.

```sql
UPDATE table_name
SET text_column = TRIM(text_column);
```

---

## 6. Validate Data Integrity
Use constraints or check invalid entries manually.

```sql
SELECT * FROM table_name WHERE column_name NOT IN ('valid_value1', 'valid_value2');
```

---

## 7. De-Duplicate Using JOINs
Remove duplicates while merging tables.

```sql
DELETE FROM table_name
WHERE id IN (
    SELECT id FROM table_name t1
    INNER JOIN table_name t2
    ON t1.column = t2.column
    WHERE t1.id < t2.id
);
```

---

## 8. Merge and Consolidate Records
Use aggregation to consolidate similar records.

```sql
SELECT column_to_group, SUM(column_to_aggregate)
FROM table_name
GROUP BY column_to_group;
```

---

## 9. Audit and Track Changes
Maintain logs of cleaning activities for future reference:

```sql
CREATE TABLE audit_log (
    operation VARCHAR(50),
    record_id INT,
    old_value TEXT,
    new_value TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO audit_log (operation, record_id, old_value, new_value)
VALUES ('UPDATE', 101, 'old_value', 'new_value');
```

---

## 10. Use Temporary Tables
Store intermediate cleaned data in temporary tables for validation.

```sql
CREATE TEMP TABLE cleaned_data AS
SELECT * FROM table_name WHERE column_name IS NOT NULL;
