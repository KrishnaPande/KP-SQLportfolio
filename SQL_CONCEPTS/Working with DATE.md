**Date/Time Data Types:**

DATE: Stores the date (year, month, day) without a time component.
TIME: Stores the time of day (hours, minutes, seconds).
TIMESTAMP: Stores both date and time without time zone.
TIMESTAMP WITH TIME ZONE (timestamptz): Stores date and time with time zone.
INTERVAL: Represents a span of time, such as 1 day or 2 hours.


**extract a specific part of a date/time value**

1. Using EXTRACT()

EXTRACT allows you to pull out specific parts of a date or timestamp by specifying a field, such as YEAR, MONTH, DAY, HOUR, etc.

``` sql
SELECT EXTRACT(YEAR FROM NOW());     -- Year
SELECT EXTRACT(MONTH FROM NOW());    -- Month
SELECT EXTRACT(DAY FROM NOW());      -- Day
SELECT EXTRACT(HOUR FROM NOW());     -- Hour
SELECT EXTRACT(MINUTE FROM NOW());   -- Minute
SELECT EXTRACT(SECOND FROM NOW());   -- Second

SELECT EXTRACT(DAY FROM TIMESTAMP '2024-10-23 15:30:00');
-- Result: 23
```

2. Using DATE_PART()

DATE_PART is similar to EXTRACT but takes the field as a string rather than a keyword.

``` sql
SELECT DATE_PART('year', NOW());     -- Year
SELECT DATE_PART('month', NOW());    -- Month
SELECT DATE_PART('day', NOW());      -- Day
SELECT DATE_PART('hour', NOW());     -- Hour
SELECT DATE_PART('minute', NOW());   -- Minute
SELECT DATE_PART('second', NOW());   -- Second

SELECT DATE_PART('month', TIMESTAMP '2024-10-23 15:30:00');
-- Result: 10
```
