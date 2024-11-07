-- Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.


-- My Solution: Dense Rank

select distinct email as Email
from (select id, email, ROW_NUMBER() over (partition by email)
from person) a
where row_number > 1

-- My Solution 2 In MYSQL

SELECT distinct email as Email
from person
where email in (select email from person group by email having count(*) > 1)

-- Solution 2: COUNT(*)

select email
from person
group by email
having count(email) > 1