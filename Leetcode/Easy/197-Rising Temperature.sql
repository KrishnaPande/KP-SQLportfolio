-- Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).


-- My solution
select id as ID
from
    (select id, recordDate + INTERVAL '0 day' as ss, temperature, LAG(temperature) over(order by recordDate) as la, LAG(recordDate + INTERVAL '1 day') over () as m
    from weather) a
where temperature > la and ss = m

-- did Not worked.
select id as ID
from
    (select id, recordDate, temperature, LAG(temperature) over(order by recordDate) as la
    from weather) a
where temperature > la

-- Remember Self join is a thing which make such problem easy.

-- Easy Solution

SELECT W1.id
FROM Weather w1
JOIN Weather w2
ON w1.recordDate = w2.recordDate + INTERVAL '1 day'
WHERE w1.temperature > w2.temperature;