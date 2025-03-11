-- Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date,
-- gender non abbreviated.

-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.


select
	concat(first_name, ' ', last_name) as patient_name,
    round(height/30.48, 1) as height_feet,
    round(weight * 2.205, 0) as weight_pounds,
    birth_date,
    (case when gender = 'M' Then 'MALE' else 'FEMALE' END) as Gender
from patients