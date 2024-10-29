--Giving no data
SELECT e.employee_id, e.name as employee_id
from employee as m
inner join employee as e
on m.employee_id = e.manager_id
where e.salary > m.manager_id