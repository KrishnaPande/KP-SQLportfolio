Self Join Problems

[https://leetcode.com/problems/rising-temperature](P197)

Easy Problem: Hear the issue is we struggle in arthematic problem. Focus on that. 
[Must Try](https://leetcode.com/problems/queries-quality-and-percentage/description/)

```sql
select  query_name,
        ROUND(SUM(rating * 1.0 / position) / COUNT(result), 2) as quality, 
        ROUND(SUM(CASE WHEN rating < 3 then 1 else 0 end) * 100.00 / count(result), 2) as poor_query_percentage
from queries
where query_name is not null
group by 1
```

2. 
[Triky Sqution Easy but must try](https://leetcode.com/problems/top-travellers/editorial/)

This is the type of question that you might want to slow down and pay attention to the details before writing:

Since the question is asking for the distance travelled by each user and there may be users who have not travelled any distance, LEFT JOIN is needed so each user from the Users table will be included.

For those users who have not travelled, functions such as IFNULL() or COALESCE() are needed to return 0 instead of null for their total distance. The two functions are a little bit different, but for this question, they can be used interchangeably.

IFNULL(): takes two arguments and returns the first one if it's not NULL or the second if the first one is NULL.

COALESCE(): takes two or more parameters and returns the first non-NULL parameter, or NULL if all parameters are NULL.

Since users might have the same name and id is the primary key for this table (which means the values in this column will be unique). We need to use id for GROUP BY to get the aggregated distance for each user.























