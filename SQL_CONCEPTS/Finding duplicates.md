**1. Using GROUP BY and HAVING**

A straightforward method to find duplicates based on one or more columns by grouping and counting occurrences.

```sql
SELECT column1, column2, COUNT(*)
FROM your_table
GROUP BY column1, column2
HAVING COUNT(*) > 1;
```

**2. Using ROW_NUMBER() with Common Table Expressions (CTE)**

This method uses a window function to rank duplicate rows based on the columns you specify, making it easier to delete duplicates while keeping the original.


```sql
WITH ranked_rows AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY column1, column2 ORDER BY id) AS row_num
    FROM your_table
)
SELECT *
FROM ranked_rows
WHERE row_num > 1;
```

> Use GROUP BY for simple identification.
> Use ROW_NUMBER() when you need more control over which duplicate to keep.