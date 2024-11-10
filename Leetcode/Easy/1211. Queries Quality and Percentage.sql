--We define query quality as:
--
--The average of the ratio between query rating and its position.
--
--We also define poor query percentage as:
--
--The percentage of all queries with rating less than 3.
--
--Write a solution to find each query_name, the quality and poor_query_percentage.
--
--Both quality and poor_query_percentage should be rounded to 2 decimal places.
--
--Return the result table in any order.
--
--The result format is in the following example.


select  query_name,
        ROUND(SUM(rating * 1.0 / position) / COUNT(result), 2) as quality,
        ROUND(SUM(CASE WHEN rating < 3 then 1 else 0 end) * 100.00 / count(result), 2) as poor_query_percentage
from queries
where query_name is not null
group by 1

-- remark: Not An easy question at all. We will have to learn how to play around CASE and arthematic links between the problems.