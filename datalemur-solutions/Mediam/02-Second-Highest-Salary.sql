-- Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

-- Solution 1: My Solution

SELECT salary
FROM (SELECT salary, RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employee) a
where salary_rank = 2

-- Solution 2: My Solution

SELECT MAX(salary) as second_highest_salary
FROM employee
where salary < (SELECT MAX(salary) FROM employee)