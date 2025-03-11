-- display the first name, last name and number of duplicate patients based on their first name and last name.

-- Ex: A patient with an identical name can be considered a duplicate.

select
	first_name,
    last_name,
    count(*) as num_of_dublicates
from patients
group by 1, 2
having count(*) > 1