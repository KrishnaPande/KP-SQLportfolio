--Need to figure out how to get leed and lag hear
with CTA as (select s.text_id, e.email_id, s.signup_action, s.action_date
from emails as e
join texts as s
on e.email_id = s.email_id
order by s.action_date)

-- Getting this value now
Now moved to
with CTA as (select s.text_id, e.email_id, s.signup_action,
  s.action_date - LAG(s.action_date) over() as daa,
  LAG(signup_action) OVER()
from emails as e
join texts as s
on e.email_id = s.email_id
order by s.action_date)