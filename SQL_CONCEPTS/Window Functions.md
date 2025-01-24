# **Window functions**



Window functions in SQL allow you to perform calculations across a set of table rows that are related to the current row, without collapsing the rows into a single output row. This is different from regular aggregate functions (like SUM or MAX), which reduce the number of rows by grouping them.


### Key Features of Window Functions

* **Partitioning**: You can divide rows into partitions based on the values of one or more columns, so the function operates within each partition independently.
* **Ordering**: You can define an order for rows within each partition.
* **Window Frame**: You can specify a subset of rows within the partition to define the "window frame" the function should operate on.
eg `(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`


* **Window functions** (e.g., MAX(...) OVER (...)) calculate values over a set of rows related to the current row without collapsing the result into a single row per group. They do not reduce the number of rows in your result.

* **Aggregate functions** (e.g., MAX(...) without OVER) aggregate data by groups and reduce the number of rows by grouping the results.

# SQL Window Functions

1. **ROW_NUMBER()**: Assigns a unique, sequential number to each row within a partition.
2. **RANK()**: Assigns a rank to each row within a partition, with gaps in ranking for ties.
3. **DENSE_RANK()**: Assigns a rank to each row within a partition without gaps for ties.
4. **NTILE(n)**: Divides rows within a partition into `n` roughly equal groups and assigns a number to each row based on its group.
5. **LAG(column, offset, default)**: Accesses data from the row at a specified offset before the current row within a partition.
6. **LEAD(column, offset, default)**: Accesses data from the row at a specified offset after the current row within a partition.
7. **FIRST_VALUE(column)**: Returns the first value in an ordered partition.
8. **LAST_VALUE(column)**: Returns the last value in an ordered partition.
9. **NTH_VALUE(column, n)**: Returns the nth value in an ordered partition.
10. **SUM(column)**: Calculates a running total of values within a partition.
11. **AVG(column)**: Calculates a running average of values within a partition.
12. **MIN(column)**: Returns the minimum value within a partition.
13. **MAX(column)**: Returns the maximum value within a partition.
14. **COUNT(column)**: Counts the rows within a partition.

## Syntax Example
```sql
SELECT column,
       SUM(column) OVER (PARTITION BY column ORDER BY column) AS running_total
FROM table;
```

# PostgreSQL-Specific Window Functions

1. **CUME_DIST()**: Calculates the cumulative distribution of a value within a partition (i.e., the relative position of the row).
2. **PERCENT_RANK()**: Computes the rank of a row as a percentage of the total rows in the partition, with values between 0 and 1.
3. **MODE()**: Returns the most frequent value within a partition (used with `WITHIN GROUP`).
4. **MEDIAN()**: Calculates the median of a set of values within a partition (used with `WITHIN GROUP`).
5. **REGR_SLOPE(), REGR_INTERCEPT()**: Calculates the slope and intercept of a least-squares-fit linear regression line for two numeric expressions within a partition.
6. **REGR_COUNT()**: Counts the number of non-NULL pairs in linear regression.
7. **REGR_R2()**: Calculates the coefficient of determination (R-squared) for the regression.
8. **REGR_AVGX(), REGR_AVGY()**: Returns the average of the independent (`x`) and dependent (`y`) values in a regression analysis.
9. **REGR_SXX(), REGR_SYY()**: Computes the sum of squares for the independent (`x`) and dependent (`y`) variables.
10. **REGR_SXY()**: Calculates the sum of products of paired values (for regression analysis).
11. **WIDTH_BUCKET()**: Places a value into one of a set of histogram bins based on specified boundaries.

## PostgreSQL-Specific Window Frame Syntax
PostgreSQL also allows custom window frame specifications, which refine the subset of rows for window functions:
- **RANGE**: Uses logical (value-based) offsets within a window frame, e.g., `RANGE BETWEEN 5 PRECEDING AND 5 FOLLOWING`.
- **ROWS**: Uses physical (row-based) offsets within a window frame, e.g., `ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING`.
- **GROUPS**: Groups rows with equal ordering values together within a window frame.

## Syntax Example with Window Frames
```sql
SELECT column,
       SUM(column) OVER (PARTITION BY column ORDER BY column ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS running_total
FROM table;
```

**WITHIN GROUP**: Used with aggregation functions like MODE() and MEDIAN() to calculate values over ordered partitions.
**Window Frames**: PostgreSQL offers flexibility in specifying frames, which can be useful for cumulative or moving window calculations.

# Window frames

Window frames in SQL (and PostgreSQL specifically) define the range of rows that a window function considers for its calculations relative to the current row. This is especially useful in cumulative, moving averages, or other sequential calculations.

### 1. **ROWS**: 
Defines the frame by a specific number of rows before or after the current row, based on the physical position.

- **Example**: `ROWS BETWEEN 3 PRECEDING AND CURRENT ROW` considers the current row and the three rows before it.

### 2. **RANGE**: 
Defines the frame based on the logical value of the rows in the ORDER BY clause. Instead of row positions, it uses value ranges.

- **Example**: `RANGE BETWEEN 100 PRECEDING AND CURRENT ROW` considers the current row and any rows with values within 100 units of the current row's value in the ORDER BY column.

### 3. GROUPS: 

Introduced in recent versions of PostgreSQL, this frame groups rows with identical values in the ORDER BY clause.

- **Example**: `GROUPS BETWEEN 1 PRECEDING AND 1 FOLLOWING` considers the current group and one group before and after it.


## Window Frame Options

You can define a window frame with these options to control the range precisely:

* **UNBOUNDED PRECEDING**: Includes all rows from the start of the partition up to the current row.
* **UNBOUNDED FOLLOWING**: Includes all rows from the current row to the end of the partition.
* **CURRENT ROW**: Includes only the current row.
* **N PRECEDING / N FOLLOWING**: Includes a specific number of rows before or after the current row.



