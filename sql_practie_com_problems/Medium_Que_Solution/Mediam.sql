-- For each doctor, display their id, full name, and the first and last admission date they attended.

select
	doctor_id,
	concat(first_name, ' ', last_name) as full_name,
	min(admission_date) as first_admission_date,
    max(admission_date) as last_admission_date
from admissions as a
join doctors as d
on a.attending_doctor_id = d.doctor_id
group by 1
order by 1