-- UnitedHealth has a program called Advocate4Me, which allows members to call an advocate and receive support for their health care needs – whether that's behavioural, clinical, well-being, health care financing, benefits, claims or pharmacy help.

-- Write a query to find how many UHG members made 3 or more calls. case_id column uniquely identifies each call made.


--  Solution 1:
SELECT COUNT(policy_holder_id) as policy_holder_count
FROM (SELECT policy_holder_id,	COUNT(case_id)
FROM callers
GROUP BY 1) a
where count >= 3

--  Solution 2:

SELECT count(policy_holder_id) as member_count
FROM (
    SELECT   policy_holder_id, count(case_id) as call_count
    FROM     callers
    GROUP BY policy_holder_id
    HAVING   count(case_id) >= 3
) as call_records

-- Can also be done through

SELECT COUNT(______) AS policy_holder_count
FROM (
  SELECT
    policy_holder_id,
    COUNT(case_id) as call_count
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
) AS call_records;