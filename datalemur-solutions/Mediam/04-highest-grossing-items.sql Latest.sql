-- Assume you're given a table containing data on Amazon customers and their spending on products in different category;
-- write a query to identify the top two highest-grossing products within each category in the year 2022.
-- The output should include the category, product, and total spend.



-- Solution 1: Using Set Operator and window function


SELECT *
FROM (SELECT category, product, SUM(spend) OVER(PARTITION BY Product ORDER BY spend) AS total_spend
FROM product_spend
WHERE category = 'appliance' and EXTRACT(YEAR from transaction_date) = 2022
ORDER BY total_spend DESC
LIMIT 2) a

UNION ALL
SELECT *
FROM (SELECT category, product, SUM(spend) OVER(PARTITION BY Product ORDER BY spend) AS total_spend
FROM product_spend
WHERE category = 'electronics'
ORDER BY total_spend DESC
LIMIT 2) a