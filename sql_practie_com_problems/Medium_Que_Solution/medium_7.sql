-- Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated.
-- Average is rounded to 2 decimal places.

select
    max(pi),
    min(pi),
    round(avg(pi), 2)
from (select
		count(patient_id) as pi
		from admissions as a
		group by (admission_date))

select
	max(number_of_visits) as max_visits,
	min(number_of_visits) as min_visits,
  round(avg(number_of_visits),2) as average_visits
from (
  select admission_date, count(*) as number_of_visits
  from admissions
  group by admission_date
)