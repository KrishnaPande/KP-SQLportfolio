-- Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

-- Solution 1:

select
	count(patient_id) as patients_in_group,
	floor(weight/10) * 10 as weight_group
from patients
group by 2
order by 2 desc

