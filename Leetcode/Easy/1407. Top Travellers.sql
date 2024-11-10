--IFNULL(): takes two arguments and returns the first one if it's not NULL or the second if the first one is NULL.
--
--COALESCE(): takes two or more parameters and returns the first non-NULL parameter, or NULL if all parameters are NULL.
--
--Since users might have the same name and id is the primary key for this table (which means the values in this column will be unique). We need to use id for GROUP BY to get the aggregated distance for each user.


select name, COALESCE(SUM(distance), '0') as travelled_distance
from users as u
left join rides as r
on u.id = r.user_id
group by r.user_id, 1
order by 2 DESC, 1

Remark: triky questions.