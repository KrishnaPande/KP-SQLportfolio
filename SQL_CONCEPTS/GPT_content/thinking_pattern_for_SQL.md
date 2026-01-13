This is the **right meta-question**.
I’ll give you a **clear thinking algorithm** — not SQL, not examples first — but **how your brain should move step by step** when you read a question.

Read this slowly. This is senior-level thinking.

---

# 🧠 THE 6-STEP THINKING MODEL

*(Subquery vs CTE vs Window)*

Whenever you read a SQL question, **do this in order — every time**.

---

## STEP 1️⃣ — What is the **final grain**?

Ask:

> “What does **one output row** represent?”

Examples:

* one customer
* one order
* one month
* one product

🔒 **This decides GROUP BY vs WINDOW**

* One row per group → GROUP BY
* One row per original row → WINDOW

❌ Do NOT think about syntax yet.

---

## STEP 2️⃣ — Do I need to **collapse rows**?

Ask:

> “Am I okay losing row-level detail?”

* YES → GROUP BY / SUBQUERY
* NO → WINDOW FUNCTION

🔒 If output says:

* “each employee with…” → WINDOW
* “total per month” → GROUP BY

---

## STEP 3️⃣ — Am I comparing **aggregates to aggregates**?

Ask:

> “Am I comparing a total/avg/count to another total/avg/count?”

Examples:

* greater than average
* above overall average
* higher than previous month

👉 **You NEED a second layer**
→ SUBQUERY or CTE

🔒 **One aggregation cannot compare itself**
It must be wrapped.

---

## STEP 4️⃣ — Is the comparison **across time or rows**?

Ask:

> “Am I comparing this row/group to a previous one?”

Examples:

* previous month
* last order
* running total
* gap between dates

👉 **WINDOW FUNCTION**

But ⚠️ important:

* If the comparison is on **aggregated data**
  → CTE first, WINDOW second

🔒 Rule:

> **Aggregate → then window, never reverse**

---

## STEP 5️⃣ — Am I checking **existence or absence**?

Ask:

> “Does this question mean ‘has’ or ‘never had’?”

Examples:

* customers with no orders
* products not sold
* users active in both months

👉 Use:

* EXISTS / NOT EXISTS
* or LEFT JOIN + IS NULL

🔒 This is **not** a WHERE filter problem.

---

## STEP 6️⃣ — Can this logic be done in **one layer**?

Ask:

> “Can everything be done without nesting?”

* If YES → single SELECT
* If NO → CTE / subquery

🔒 Seniors **prefer CTEs** because:

* clearer logic
* easier debugging
* interview-friendly

---

# 🧠 DECISION FLOW (MEMORIZE)

```
Final row = group?      → GROUP BY
Final row = original?  → WINDOW

Compare aggregates?    → SUBQUERY / CTE
Compare over time?     → WINDOW

Need both?             → CTE → WINDOW

Exist / Never?         → EXISTS / NOT EXISTS
```

---

# 🔥 VERY IMPORTANT (this fixes your block)

### ❌ What you were doing before

* Start writing SQL
* Get stuck
* Backtrack

### ✅ What seniors do

1. Identify grain
2. Decide collapse vs preserve
3. Decide single layer vs multi-layer
4. THEN write SQL

---

# 🧩 One real example (mental only)

> “Find months where sales increased vs previous month”

Brain path:

1. Output row = month
2. Need total per month → GROUP BY
3. Need comparison vs previous → WINDOW
4. Cannot window raw data → CTE
5. Done

No confusion.

---

# 🧠 FINAL LOCK (say this mentally)

> **“What is my row, and what am I comparing it to?”**

If you answer that, SQL writes itself.

---

Next (recommended):

* I give **5 mixed questions**
* You reply with **only the 6-step reasoning**, no SQL

That will permanently fix this.

Say **“drill”** if you want that.
