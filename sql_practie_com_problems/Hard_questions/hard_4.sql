-- All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date

select
	p.patient_id,
    CONCAT(p.patient_id, len(p.last_name), year(birth_date))
from patients as p
join admissions as a on p.patient_id = a.patient_id
group by 1

-- Solution 2:

select
  distinct p.patient_id,
  p.patient_id || floor(len(last_name)) || floor(year(birth_date)) as temp_password
from patients p
  join admissions a on p.patient_id = a.patient_id

-- Solution 3:
select
  pa.patient_id,
  ad.patient_id || floor(len(pa.last_name)) || floor(year(pa.birth_date)) as temp_password
from patients pa
  join admissions ad on pa.patient_id = ad.patient_id
group by pa.patient_id;

