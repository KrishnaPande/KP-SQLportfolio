-- A senior analyst is interested to know the activation rate of specified users in the emails table.

-- Write a query to find the activation rate.
-- Round the percentage to 2 decimal places.


SELECT
      ROUND(SUM(CASE WHEN t.signup_action = 'Confirmed' THEN 1 ELSE 0 END)*1.0 / COUNT(t.signup_action),2)
FROM emails e
JOIN texts t
ON e.email_id = t.email_id


-- remarks:
-- 1. tried using "count filter when" fisrt --> didnt work.
-- 2. was doing COUNT(*) initially.