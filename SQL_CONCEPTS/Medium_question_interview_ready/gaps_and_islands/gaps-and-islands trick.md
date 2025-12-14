Short answer: **Learn the gaps-and-islands trick first — then try solving with both it and `lead()`/`lag()`**.

Why: the `date - row_number()` trick is compact, robust, and scale-friendly for grouping consecutive rows into islands. `lead()`/`lag()` is intuitive and okay for detecting boundaries, but it often leads to more code and edge-case handling. Knowing both makes you faster in interviews.

Quick explanations + ready-to-use SQL (two approaches):

### 1) Gaps & Islands — `date - ROW_NUMBER()` (recommended)

Idea: for consecutive dates, `sale_date - row_number()` is constant within a streak — use that constant to group.

```sql
WITH numbered AS (
  SELECT
    user_id,
    login_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS rn
  FROM logins
),
grp AS (
  SELECT
    user_id,
    login_date,
    DATEADD(day, -rn, login_date) AS grp_key  -- use DATEadd/DATE_SUB depending on DB
  FROM numbered
)
SELECT
  user_id,
  MIN(login_date) AS streak_start,
  MAX(login_date) AS streak_end,
  COUNT(*)        AS streak_length
FROM grp
GROUP BY user_id, grp_key
ORDER BY user_id, streak_start;
```

Notes: replace `DATEADD(day, -rn, login_date)` with your DB’s date arithmetic (e.g., `login_date - rn * INTERVAL '1 day'` or `DATE_SUB(login_date, INTERVAL rn DAY`).

### 2) Boundary-detection with `lag()` (alternate)

Idea: mark where streaks start (prev_date <> curr_date - 1), then cumulative sum to build groups.

```sql
WITH flagged AS (
  SELECT
    user_id,
    login_date,
    CASE
      WHEN LAG(login_date) OVER (PARTITION BY user_id ORDER BY login_date) = DATEADD(day, -1, login_date)
      THEN 0 ELSE 1 END AS is_start
  FROM logins
),
grp AS (
  SELECT
    user_id,
    login_date,
    SUM(is_start) OVER (PARTITION BY user_id ORDER BY login_date ROWS UNBOUNDED PRECEDING) AS grp_id
  FROM flagged
)
SELECT
  user_id,
  MIN(login_date) AS streak_start,
  MAX(login_date) AS streak_end,
  COUNT(*)        AS streak_length
FROM grp
GROUP BY user_id, grp_id
ORDER BY user_id, streak_start;
```

### Practical advice

* Learn the `date - row_number()` trick first (1–2 examples). It’s short, elegant, and interviewers love it.
* Then practice the `lag()`/`lead()` approach so you can reason about boundaries and explain alternatives.
* For interviews: if you remember the trick, use it — faster to write and explain. If you forget, `lag()` is a safe fallback.

Want: I can now give you 3 quick exercises (in increasing difficulty) to practice the trick — do you want them?
