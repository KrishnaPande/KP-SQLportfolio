Alright. **Mock interview continues.**
New question, **different pattern**, still very realistic.

---

## 🎤 Mock Interview – Question 2 (Very Common)

### **Context**

You’re analyzing customer revenue behavior for a retail company.

### **Table**

`orders`

```text
user_id
order_date   (DATE)
order_id
revenue
```

---

## **Interview Question**

> **Find users whose monthly revenue increased for at least 3 consecutive months
> and then dropped in the immediately following month.**

---

## **Clarifications (assume unless you ask)**

* Monthly revenue = **SUM(revenue) per user per month**
* “Increased” = **strictly increasing** month over month
* “Dropped” = revenue **less than previous month**
* If user has no next month → **do NOT count as drop**
* Output: `user_id`

---

## What I want from you (same mock format)

Answer by **thinking aloud**, in this order:

1️⃣ Clarify assumptions
2️⃣ English logic
3️⃣ Proof mechanism
4️⃣ Query shape
5️⃣ SQL (PostgreSQL)

I will interrupt you like a real interviewer if needed.

Go ahead.

---

Good thinking — you’re **very close**. I’ll respond like an interviewer and **tighten your logic**, step by step, and fix the exact place you’re stuck.

---

## Interviewer pause ✋ — key correction first

You mixed **two different ideas**:

* ❌ *“consecutive months”*
* ❌ *“revenue trend”*

For this question, **consecutive months are NOT the hard part**.
The hard part is **consecutive revenue increases**.

👉 You do **NOT** need `month_index - row_number` streak logic here.

That pattern is for **missing months**, not **value trends**.

---

## Let’s reset and do it cleanly (this is important)

### Question again (simplified)

> Monthly revenue goes **up for 3 months in a row**,
> then **drops in the immediately next month**.

---

## ✅ Step 1 – English logic (corrected)

> “For each user, compute monthly revenue.
> Compare each month’s revenue with the previous month to see if it increased or decreased.
> Find users who had **three consecutive month-over-month increases**, followed by a **drop in the next month**.”

Say this clearly in interviews — this already sounds senior.

---

## ✅ Step 2 – Proof mechanism (THIS was missing)

We need **two proofs**:

### Proof A: revenue increase

```text
rev > lag(rev)
```

### Proof B: three increases **in a row**

We convert increase into a **flag**:

```sql
CASE WHEN rev > lag_rev THEN 1 ELSE 0 END
```

Then:

> 3 consecutive `1`s

### Proof C: drop immediately after

```text
rev < lag(rev)
```

on the **next month after the 3rd increase**

---

## ✅ Step 3 – Query shape (this unlocks everything)

Say this aloud:

1. Aggregate revenue per user per month
2. Use window functions to compare revenue month-over-month
3. Turn comparisons into increase / decrease flags
4. Detect **3 consecutive increases**
5. Check **next month is a drop**

This tells the interviewer you control the flow.

---

## ✅ Step 4 – Correct SQL (PostgreSQL)

```sql
WITH monthly_revenue AS (
  SELECT
    user_id,
    DATE_TRUNC('month', order_date) AS month,
    SUM(revenue) AS rev
  FROM orders
  GROUP BY user_id, month
),
rev_changes AS (
  SELECT
    user_id,
    month,
    rev,
    LAG(rev) OVER (PARTITION BY user_id ORDER BY month) AS prev_rev,
    LEAD(rev) OVER (PARTITION BY user_id ORDER BY month) AS next_rev
  FROM monthly_revenue
),
flags AS (
  SELECT
    user_id,
    month,
    CASE WHEN rev > prev_rev THEN 1 ELSE 0 END AS inc_flag,
    CASE WHEN next_rev < rev THEN 1 ELSE 0 END AS drop_next_flag
  FROM rev_changes
),
windows AS (
  SELECT
    user_id,
    month,
    SUM(inc_flag) OVER (
      PARTITION BY user_id
      ORDER BY month
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS inc_3_window,
    drop_next_flag
  FROM flags
)
SELECT DISTINCT user_id
FROM windows
WHERE inc_3_window = 3
  AND drop_next_flag = 1;
```

---

## 🧠 The BIG mental correction (lock this in)

### 🔒 Rule

> **Consecutive time ≠ consecutive increase**

* Missing months → `month_index - row_number`
* Trend direction → `LAG / LEAD + sliding window`

You were about to overuse streak logic — catching this now is huge.

---

## Interviewer verdict (honest)

* Your **intuition** is strong
* You correctly identified `LAG` and month aggregation
* You just needed to **separate “time continuity” from “value trend”**

That’s a senior-level distinction.

---

## Want one more?

Next mock can test:

* churn logic
* customer reactivation
* or YoY comparison

Say:
**“One more mock (churn / retention / YoY)”**

