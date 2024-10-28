-- Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.

-- Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.


-- Easy Solution:
SELECT  COUNT(device_type) as laptop_views,
        (SELECT COUNT(*) FROM viewership) - COUNT(device_type) as mobile_views
FROM    viewership
WHERE   device_type = 'laptop'


-- Solution 1: using [CASE WHEN THEN ELSE]

SELECT Sum(CASE
             WHEN device_type = 'laptop' THEN 1
             ELSE 0
           END) AS laptop_views,
       Sum(CASE
             WHEN device_type IN ( 'tablet', 'phone' ) THEN 1
             ELSE 0
           END) AS mobile_views
FROM   viewership;


-- Solution 2 : using FILTER (didnt knew FILTER existed)

SELECT Count(*) filter( WHERE device_type='laptop')         AS laptop_views,
       Count(*) filter( WHERE device_type IN('tablet', 'phone')) AS mobile_views
FROM   viewership;


-- Solution 3: using JOINs (wolud not have thought)

SELECT Count(DISTINCT a.user_id) AS "laptop_views",
       Count(DISTINCT b.user_id) AS "mobile_views"
FROM   viewership AS a
       INNER JOIN viewership AS b
               ON a.device_type = 'laptop'
                  AND b.device_type IN ( 'tablet', 'phone' )



-- REMARKS :
-- 1. didn't get the idea to use 'THEN 1 ELSE 0' --> makes it very easy to solve.
-- 2. also can use NOT IN('laptop') everywhere instead of, IN ('tablet', 'phone')