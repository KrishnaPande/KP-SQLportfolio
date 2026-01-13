Good. Day-2 revision should **lock foundations + logic patterns**, not random questions.
I’ll do this in **two tight parts**:

1️⃣ **Compact THEORY (PostgreSQL-specific, factual)**
2️⃣ **10 Medium–Hard LOGIC questions** (date + join + subquery heavy)

No fluff. This is how seniors revise.

---

# PART 1 — DATE + LOGIC THEORY (PostgreSQL)

## 1️⃣ Date arithmetic (date-add / subtract)

### What it is

Adding or subtracting time from a date or timestamp.

### Syntax

```sql
date_col + INTERVAL '5 days'
date_col - INTERVAL '2 months'
```

### Key points

* INTERVAL is mandatory
* Supports: day, week, month, year, hour, minute
* No default values — must specify unit

🧠 Mental rule

> **Postgres = date ± INTERVAL**

---

## 2️⃣ Date difference

### Option 1: Direct subtraction

```sql
date2 - date1
```

Returns **integer days** (if DATE) or **interval** (if TIMESTAMP)

### Option 2: Extract from interval

```sql
EXTRACT(DAY FROM (date2 - date1))
```

🧠 Mental rule

> **Postgres does NOT have DATEDIFF()**

---

## 3️⃣ EXTRACT vs DATE_PART

Same thing, different syntax.

```sql
EXTRACT(YEAR FROM date_col)
DATE_PART('year', date_col)
```

Use cases:

* Filtering (year = 2024)
* Grouping (month, week)

---

## 4️⃣ DATE_TRUNC (time bucketing)

### What it does

Rounds down a timestamp to a unit.

```sql
DATE_TRUNC('month', date_col)
DATE_TRUNC('week', date_col)
```

### Why it matters

* Correct monthly grouping (includes year)
* Safe for analytics

🧠 Mental rule

> **Never group by EXTRACT(month) alone**

---

## 5️⃣ WHERE vs HAVING (date edition)

| Scenario                        | Use    |
| ------------------------------- | ------ |
| Filter rows by date             | WHERE  |
| Filter groups by date aggregate | HAVING |

Wrong:

```sql
WHERE COUNT(*) > 5 ❌
```

Correct:

```sql
HAVING COUNT(*) > 5 ✅
```

---

## 6️⃣ EXISTS / NOT EXISTS (date logic)

### When to use

* “has activity”
* “never happened”
* “at least once”

```sql
WHERE EXISTS (
  SELECT 1 FROM orders o
  WHERE o.user_id = u.user_id
  AND o.order_date >= CURRENT_DATE - INTERVAL '30 days'
)
```

🧠 Mental rule

> **EXISTS = presence check, stops at first match**

---

## 7️⃣ JOIN vs SUBQUERY (date-heavy logic)

| Question type          | Tool                   |
| ---------------------- | ---------------------- |
| “never”, “no record”   | LEFT JOIN / NOT EXISTS |
| “greater than average” | SUBQUERY               |
| “latest per user”      | WINDOW or JOIN         |

---

## 8️⃣ FILTER (date-conditional aggregation)

Used when:

* Multiple date conditions in one query

```sql
COUNT(*) FILTER (WHERE order_date >= CURRENT_DATE - INTERVAL '7 days')
```

🧠 Mental rule

> **FILTER = conditional aggregate, not row filter**

---

## 9️⃣ Window functions + date

Allowed inside `PARTITION BY`:

* date_trunc
* extract
* expressions

```sql
SUM(amount) OVER (
  PARTITION BY DATE_TRUNC('month', order_date)
)
```

❌ Cannot be used in WHERE

---

## 10️⃣ Common interview traps

* Month without year ❌
* Using WHERE with aggregates ❌
* Using MAX(date) + join incorrectly ❌
* Forgetting tie handling ❌

---

# PART 2 — 10 MEDIUM–HARD REVISION QUESTIONS

Answer later. For now, **just read and think**.

---

### Q1

Find users who placed **orders in both Jan 2024 and Feb 2024**.

*(Date comparison + grouping logic)*

---

### Q2

Find products that were **not sold in the last 90 days**.

*(NOT EXISTS vs LEFT JOIN)*

---

### Q3

For each user, find the **gap (in days)** between their last two orders.

*(Window + date diff)*

---

### Q4

Find months where **total sales increased compared to previous month**.

*(Window + DATE_TRUNC)*

---

### Q5

Find customers whose **first order date** is in 2023 but **no orders in 2024**.

*(Subquery + date filter)*

---

### Q6

Find users who placed **more than 3 orders within any 7-day window**.

*(Hard — rolling window logic)*

---

### Q7

For each month, show **number of active users** (users with ≥1 order).

*(Distinct + date_trunc)*

---

### Q8

Find orders that happened **on the same day as the customer’s first order**.

*(Correlated subquery + date)*

---

### Q9

For each user, show their **latest order date** and **days since last order**.

*(Window + current_date)*

---

### Q10

Find products whose **average monthly sales in 2024** is greater than **overall monthly average**.

*(Nested aggregation + subquery)*

---

## How we’ll proceed (important)

Next step:

* You pick **Q1–Q3**
* Answer **logic + approach only** (no full SQL)
* I’ll correct **thinking**, not syntax

You’re absolutely on the **right track**.
This is exactly how senior analysts revise.


---

Good. I’ll be **strict, point-by-point**, exactly what you asked.
I’ll do **Q1–Q6**, mark **RIGHT / WRONG**, fix logic, then give **memory locks** and **one level-up question + approach** for each.

No fluff.

---

# Q1️⃣ Users who ordered in **both Jan & Feb 2024**

### Your answer

```sql
where date between '2024-01-01' and '2024-02-01'
group by user_id
having count(distinct date_trunc('month', date)) = 2
```

### ❌ Issues

1. Date range is **wrong**

   * `'2024-02-01'` excludes most of Feb
2. Logic idea is correct, execution slightly off

### ✅ Correct logic

```sql
WHERE date >= '2024-01-01'
  AND date <  '2024-03-01'
GROUP BY user_id
HAVING COUNT(DISTINCT DATE_TRUNC('month', date)) = 2
```

### 🧠 Memory lock

> **“both months” → COUNT(DISTINCT month) = N**

### 🔼 Level-up question

**Users active in ALL months of 2024**

**Approach**

* Filter year
* Group by user
* Count distinct months = 12

---

# Q2️⃣ Products **not sold in last 90 days**

### Your answer

```sql
not exist(select 1 from data 
where date between current_date and current_date - interval '90 day')
```

### ❌ Issues (important)

1. Date range reversed
2. Missing **correlation**
3. `NOT EXISTS` logic incomplete

### ✅ Correct logic

```sql
NOT EXISTS (
  SELECT 1
  FROM orders o
  WHERE o.product_id = p.product_id
    AND o.order_date >= CURRENT_DATE - INTERVAL '90 days'
)
```

### 🧠 Memory lock

> **NOT EXISTS always needs correlation**

### 🔼 Level-up question

**Products never sold at all**

**Approach**

* NOT EXISTS
* No date condition

---

# Q3️⃣ Gap between consecutive orders

### Your answer

```sql
date - lag(date) over (partition by user_id order by date)
```

### ✅ Correct (minor typo ignored)

### 🧠 Memory lock

> **Row-to-row difference → LAG + subtraction**

### 🔼 Level-up question

**Largest gap between orders per user**

**Approach**

* Compute gap with LAG
* Then MAX(gap) using GROUP BY or window

---

# Q4️⃣ Months where sales increased vs previous month

### Your answer

You said: *first aggregate then compare* — ✅ correct thinking

### ❌ Issues in SQL sketch

* Syntax messy
* Missing proper filtering step

### ✅ Correct structure

```sql
WITH monthly AS (
  SELECT
    DATE_TRUNC('month', date) AS month,
    SUM(sales) AS total_sales
  FROM data
  GROUP BY 1
)
SELECT month
FROM (
  SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS prev_sales
  FROM monthly
) t
WHERE total_sales > prev_sales;
```

### 🧠 Memory lock

> **Aggregate first, window second**

### 🔼 Level-up question

**Months where sales increased for 3 consecutive months**

**Approach**

* LAG twice
* Compare current > lag1 > lag2

---

# Q5️⃣ Users whose **first order was in 2023** and **no orders in 2024**

### Your answer

❌ **This is wrong and confused**

Problems:

* FIRST_VALUE alone not enough
* WHERE + NOT EXISTS mixed incorrectly
* Year filtering logic broken

### ✅ Correct mental model

Two conditions:

1. First order year = 2023
2. No orders in 2024

### ✅ Correct logic

```sql
-- condition 1
EXTRACT(YEAR FROM MIN(order_date)) = 2023

-- condition 2
NOT EXISTS (
  SELECT 1
  FROM orders o2
  WHERE o2.user_id = o.user_id
    AND EXTRACT(YEAR FROM o2.order_date) = 2024
)
```

(Used in GROUP BY or subquery)

### 🧠 Memory lock

> **“first” → MIN(date)**
> **“no activity later” → NOT EXISTS**

### 🔼 Level-up question

**Users whose first order was in 2023 AND last order was in 2023**

**Approach**

* MIN(date) year = 2023
* MAX(date) year = 2023

---

# Q6️⃣ Users with **>3 orders in any 7-day window**

### Your answer

You tried window count — **right direction**, but ❌ wrong execution

### ❌ Issues

1. `ROWS BETWEEN` ≠ time window
2. ROWS = number of rows, not days
3. GROUP BY breaks window logic

### ✅ Correct logic (PostgreSQL)

```sql
COUNT(*) OVER (
  PARTITION BY user_id
  ORDER BY order_date
  RANGE BETWEEN INTERVAL '6 days' PRECEDING AND CURRENT ROW
)
```

Then filter where count > 3.

### 🧠 Memory lock

> **ROWS = row count**
> **RANGE = time window**

### 🔼 Level-up question

**Users with >5 orders in any rolling 30-day window**

**Approach**

* RANGE BETWEEN INTERVAL '29 days' PRECEDING
* Window count
* Filter > 5

---

# 🔒 FINAL MEMORY FIX (IMPORTANT)

### 8 NON-NEGOTIABLE RULES

1. “both / all” → GROUP BY + HAVING
2. “never / no activity” → NOT EXISTS
3. PostgreSQL date math → INTERVAL
4. Row-to-row → LAG / LEAD
5. Aggregate before window
6. RANGE ≠ ROWS
7. FIRST = MIN(date), not FIRST_VALUE usually
8. If logic has **two time conditions**, split them

---

## Your real status (honest)

* Logic level: **strong**
* Mistakes: **boundary conditions + syntax recall**
* Thinking pattern: **correct and improving fast**

You are **not stuck anymore**. You’re refining.

---

### Next (pick one):

1. 🔥 5 **rolling-window interview killers**
2. 🔥 EXISTS vs LEFT JOIN speed drill
3. 🔥 One **full hard analytics query** end-to-end

Say the number.
