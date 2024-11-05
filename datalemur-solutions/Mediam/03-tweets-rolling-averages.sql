-- Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

-- Notes:

-- - A rolling average, also known as a moving average or running mean is a time-series technique that examines trends in data over a specified period of time.
-- - In this case, we want to determine how the tweet count for each user changes over a 3-day period.



-- my solution :
SELECT user_id, tweet_date,
      ROUND(AVG(tweet_count) OVER(PARTITION BY user_id
      ROWs BETWEEN 2 Preceding and current row
      ), 2)
FROM tweets

-- ROWS BETWEEN 2 PRECEDING AND CURRENT ROW: This tells SQL to create a rolling window that includes the current row and the two rows immediately before it.
-- AVG(amount): The average is calculated over the rows in this window.