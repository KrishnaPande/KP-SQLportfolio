-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

select
	concat(p.first_name, ' ', p.last_name),
    a.diagnosis,
    concat(d.first_name, ' ', d.last_name)
from patients as p
	join admissions as a ON p.patient_id = a.patient_id
    join doctors as d on a.attending_doctor_id = d.doctor_id