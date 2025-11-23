SELECT first_name, last_name, count(patient_id) as admissions_total
from doctors as d
join admissions as a
on d.doctor_id = attending_doctor_id
group by 1, 2