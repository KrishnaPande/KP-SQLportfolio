-- A Microsoft Azure Supercloud customer is defined as a company that purchases at least one product from each product category.

-- Write a query that effectively identifies the company ID of such Supercloud customers.



-- Solution :

SELECT customer_id
FROM (SELECT c.customer_id, COUNT(distinct p.product_category),
      (SELECT COUNT(DISTINCT product_category) FROM products) c
FROM customer_contracts c
JOIN products p
ON c.product_id = p.product_id
GROUP BY c.customer_id) a
WHERE count = c

-- remarks: Its getting easier now