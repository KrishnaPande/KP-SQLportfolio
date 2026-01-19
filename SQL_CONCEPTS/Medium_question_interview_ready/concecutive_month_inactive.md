Perfect. We’ll do a **real mock interview** — exactly how it happens in analytics / data interviews.

### Mock Interview Rules (important)

* I’m the interviewer.
* You **think aloud**.
* No rushing to SQL.
* I may interrupt and ask *why*.
* Focus on **clarity, assumptions, and structure**.

---

## 🎤 Mock Interview – Question 1 (Retail / Analytics)

### **Context**

You’re working with a retail analytics team.

### **Table**

`transactions`

```text
user_id
transaction_date   (DATE)
order_id
amount
```

---

### **Question**

> **Identify users who became inactive after being active for at least 4 consecutive months.**

---

### **Clarifications (assume unless you ask)**

* “Active” = at least **one transaction in a month**
* Months are **calendar months**
* Inactive means **no transactions in the immediately following month**
* Output: `user_id`

---

### What I want from you

Think aloud and answer in this order:

1️⃣ Clarify assumptions (if any)
2️⃣ English logic (plain language)
3️⃣ Proof mechanism (how data proves this)
4️⃣ Query shape (CTEs / windows / grouping)
5️⃣ SQL (PostgreSQL)

I may stop you mid-way like a real interviewer.

Go ahead.
---

Good — you’re **on the right path**, but as an interviewer I would **pause you here** and tighten your thinking. I’ll respond **in mock-interview style**: what’s correct, what’s missing, and how to fix it.

---

## 👂 Interviewer feedback (live)

### What you did well ✅

* ✔️ You immediately went to **month-level** → correct
* ✔️ You chose **row_number + month_index** → correct
* ✔️ You identified **consecutive logic** → correct
* ✔️ You structured it into **CTEs** → senior habit

So fundamentals are solid.

---

## ❌ What’s missing (important)

You said:

> “using having = 4 and you will have an id of user who became inactive in that month”

This is where I’d stop you in a real interview.

### Why this is incomplete

`HAVING COUNT(*) = 4` only proves:

> “User had a 4-month streak”

It does **NOT** prove:

> “User became inactive **after** that streak”

You haven’t yet shown **inactivity in the immediately following month**.

---

## 🔧 How to fix your thinking (still Step-by-Step)

I’ll reframe your answer the way an interviewer expects to hear it.

---

## ✅ Step 1 – English logic (refined)

> “For each user, find sequences of 4 consecutive active months, then check whether the user had **no transaction in the immediately next month**.”

This sentence must come **before SQL**.

---

## ✅ Step 2 – Proof mechanism (this is the missing piece)

We need **two proofs**:

1. **Proof of consecutive activity**

   * month_index − row_number → streak_key
   * group by streak_key
   * count ≥ 4

2. **Proof of inactivity**

   * the month **right after the streak end** does NOT exist

That second proof was missing.

---

## ✅ Step 3 – Query shape (corrected)

Say this out loud in interviews:

> “First I collapse data to user-month level.
> Then I assign row numbers and a month index.
> Then I group consecutive months into streaks.
> Finally, I check whether the next month after a qualifying streak is missing.”

That tells the interviewer you control the logic.

---

## ✅ Step 4 – Correct SQL (PostgreSQL)

```sql
WITH user_months AS (
  SELECT DISTINCT
         user_id,
         DATE_TRUNC('month', transaction_date) AS month
  FROM transactions
),
ordered_months AS (
  SELECT
    user_id,
    month,
    EXTRACT(YEAR FROM month) * 12
      + EXTRACT(MONTH FROM month) AS month_index,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY month
    ) AS rn
  FROM user_months
),
streaks AS (
  SELECT
    user_id,
    month_index,
    month_index - rn AS streak_key
  FROM ordered_months
),
streak_summary AS (
  SELECT
    user_id,
    streak_key,
    MAX(month_index) AS end_month,
    COUNT(*) AS streak_length
  FROM streaks
  GROUP BY user_id, streak_key
)
SELECT DISTINCT s.user_id
FROM streak_summary s
WHERE s.streak_length >= 4
  AND NOT EXISTS (
    SELECT 1
    FROM ordered_months o
    WHERE o.user_id = s.user_id
      AND o.month_index = s.end_month + 1
  );
```

---

## 🧠 Interviewer takeaway (this matters)

### What separates mid vs senior here:

* ❌ “HAVING COUNT = 4”
* ✅ “Check **absence of the next expected month**”

### Mental rule to lock in

> **Streak ≠ inactivity**
> Inactivity = **missing immediate successor**

---

## ⭐ How you’re doing (honest assessment)

* Your **intuition** is strong
* Your **structure** is 80% there
* The remaining 20% is **explicitly proving the business condition**

That’s exactly what mock interviews are for.

---

## Ready for the next mock question?

Next one will test:

* trend direction
* window comparison
* business explanation

Say:

> **“Next mock interview question”**

You’re progressing like a senior analyst now.
