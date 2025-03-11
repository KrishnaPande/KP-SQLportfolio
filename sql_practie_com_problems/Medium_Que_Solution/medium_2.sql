--: Display the total amount of patients for each province. Order by descending.

select
	province_names,
	count(patient_id) as patient_count
from patients as p
	join province_names as pn ON p.province_id = pn.province_id
group by 1
order by 2 desc;