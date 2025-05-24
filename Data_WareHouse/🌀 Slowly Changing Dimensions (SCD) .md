Let’s gooo 🌀— **Slowly Changing Dimensions (SCD)** is one of the most interesting and **real-world** concepts in Data Warehousing!

---

## 🧠 What is SCD?

SCD deals with the **management of historical changes** in **dimension data**.

> Think: *"What happens when a customer's address or job title changes over time? Do we overwrite it? Or keep both versions?"*

---

## 🗂️ Why is it Important?

In analytical systems, sometimes you want to:

* 🔁 See only the **latest** data
* 🕰️ Track **changes over time**
* 👀 Retain **historical context** for facts

---

## 🌀 Types of Slowly Changing Dimensions

### ✅ SCD Type 0 – **Retain Original**

* No changes are allowed.
* Value stays the same forever.

🧪 Example: Birth Date, National ID

---

### 🔁 SCD Type 1 – **Overwrite**

* **Updates the value**, forgets the old value.
* No history tracked.

🧪 Example:

| Cust\_ID | Name  | City             |
| -------- | ----- | ---------------- |
| 101      | Priya | Mumbai    → Pune |

> Great for fixing errors (e.g., typos in names).

---

### 🧱 SCD Type 2 – **Add New Row**

* Keeps full **history** by adding a **new record** with:

  * New version
  * Start/End dates or active flags

🧪 Example:

| Cust\_ID | Name  | City   | Start\_Date | End\_Date  | Current |
| -------- | ----- | ------ | ----------- | ---------- | ------- |
| 101      | Priya | Mumbai | 2020-01-01  | 2023-01-01 | N       |
| 101      | Priya | Pune   | 2023-01-02  | NULL       | Y       |

> Excellent for **audit trails**, **historical analysis**, **trend tracking**

---

### 🧠 SCD Type 3 – **Add New Column**

* Keeps **limited history** (like previous + current values)
* Adds a new column to store old value.

🧪 Example:

| Cust\_ID | Name  | City\_Current | City\_Previous |
| -------- | ----- | ------------- | -------------- |
| 101      | Priya | Pune          | Mumbai         |

> Useful when only **one change** matters — not full history.

---

### ⚡ Other Less Common Types:

* **SCD Type 4** – Store changes in **separate historical table**
* **SCD Type 6** – Hybrid of Type 1 + 2 + 3 (complex modeling)

---

## 🎯 Summary

| Type | Method         | Keeps History? | Use When...                |
| ---- | -------------- | -------------- | -------------------------- |
| 0    | No change      | ❌ No           | Data should never change   |
| 1    | Overwrite      | ❌ No           | You want only latest value |
| 2    | Add new row    | ✅ Yes          | Track full change history  |
| 3    | Add new column | ☑️ Partial     | Need only recent change    |

---

## 🚀 Real-World Use Case:

| Scenario                      | Best SCD Type |
| ----------------------------- | ------------- |
| Address or Salary changes     | Type 2        |
| Fixing a typo in name         | Type 1        |
| Only care about last 2 cities | Type 3        |

---

Let me know if you want:

* 💻 SQL or ETL example of SCD2
* 🔄 ETL vs ELT next
* 📊 Additive vs Semi/Non Additive Facts

Your choice, professor in the making 😎

Alright, let's make this **fun** and challenging with a quiz! Here are a few questions to test your knowledge on **Slowly Changing Dimensions (SCD)**.

---

### 📝 **Quiz on Slowly Changing Dimensions (SCD)**

---

**1. What is the main difference between SCD Type 1 and SCD Type 2?**

a) Type 1 keeps the full history, while Type 2 overwrites the existing values.
b) Type 2 keeps the full history by adding new rows, while Type 1 overwrites the existing data.
c) Type 1 and Type 2 are the same.
d) Type 2 is used for smaller datasets and Type 1 for large datasets.

---

**2. Which SCD type would you use to track changes in a customer's address, where you need to store every change to the address over time?**

a) Type 1
b) Type 2
c) Type 3
d) Type 0

---

**3. In SCD Type 2, which of the following would you typically add to the table to track historical data?**

a) Start Date and End Date
b) Old Value Column
c) Status Flag (Active/Inactive)
d) Both a and c

---

**4. If you have a scenario where a customer’s salary is corrected after a mistake, and you don’t need to keep the previous salary value, which SCD type should you use?**

a) Type 1
b) Type 2
c) Type 3
d) Type 4

---

**5. Which SCD type would be most appropriate if you only need to store the current and previous city for a customer, but no historical information beyond that?**

a) Type 1
b) Type 2
c) Type 3
d) Type 0

---

**6. In SCD Type 3, you would typically add a new column for the previous value. What is the limitation of this approach?**

a) It cannot store historical data beyond the last change.
b) It keeps full history for each change.
c) It uses too much storage space.
d) It only works for unstructured data.

---

**7. Which SCD type would you use if you want to store changes in a **separate table** for historical tracking, rather than in the same table?**

a) Type 3
b) Type 4
c) Type 6
d) Type 2

---

### 🧠 **Bonus Question:**

**8. You are tracking a customer’s job title. After 3 months, their job title changes from “Junior Developer” to “Senior Developer.” After 6 months, they get promoted to “Lead Developer.” Which SCD type will you use to capture all these changes over time?**

a) Type 2
b) Type 3
c) Type 1
d) Type 0

---

### **Answers:**

1. **b)** Type 2 keeps the full history by adding new rows, while Type 1 overwrites the existing data.
2. **b)** Type 2 — to track all address changes over time.
3. **d)** Both a and c — Start Date, End Date, and Status Flag are common to track historical records.
4. **a)** Type 1 — to overwrite the incorrect salary value.
5. **c)** Type 3 — to store current and previous values.
6. **a)** It cannot store historical data beyond the last change.
7. **b)** Type 4 — separate table for historical tracking.
8. **a)** Type 2 — to store all job title changes over time.

---

How did you do? 😎 Let me know if you want a deeper dive into any of these concepts!
