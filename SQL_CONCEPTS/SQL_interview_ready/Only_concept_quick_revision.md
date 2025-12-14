# ⭐ **One-line explanations you asked for (clean, interview-ready)**

### **RANK()**

* Assigns tied rows the same rank but **skips the next number** (1, 1, 3, 4…).
  **Use when ties should push the next rank forward.**

### **DENSE_RANK()**

* Assigns tied rows the same rank but **does NOT skip numbers** (1, 1, 2, 3…).
  **Use when you want top N without gaps.**

### **ROW_NUMBER()**

* Assigns a **unique** row number even for ties (1, 2, 3, 4).
  **Use when you want exactly one row per group (e.g., latest record).**

---

# ⭐ **Mandatory Rule for All Window Functions (YOUR REQUEST)**

Every window function **must** include:

### ✔ `PARTITION BY`

Defines **subgrouping**. If you omit it, the window is calculated over **entire table** (common interview mistake).

### ✔ `ORDER BY`

Defines **ranking/sequence**.
If you omit it:

* `ROW_NUMBER()` becomes unstable / meaningless
* `RANK()` & `DENSE_RANK()` require ordering — you *must* include it
* Aggregate window functions **can** omit order (e.g., AVG() OVER (PARTITION BY dept)) but ordering changes the calculation (running vs. fixed window).

---

# ⭐ **Edge Cases Candidates Forget (your request)**

### **1. NULL salaries**

Window functions treat NULLs as:

* lowest values when ordering ASC
* highest values when ordering DESC (depends on DB)
  → Good analysts explicitly specify: `ORDER BY salary DESC NULLS LAST`.

### **2. Ties with decimals / floats**

Salary can be float → small precision differences break ties unexpectedly.

### **3. Multiple employees with exact same salary**

Need to decide:

* Should they share rank? (Use RANK or DENSE_RANK)
* Or choose one deterministically? (Use ROW_NUMBER with tie-breaker ORDER BY emp_id)

### **4. Forgetting ORDER BY in final output**

Window ORDER BY ≠ query ORDER BY.

### **5. Window vs. GROUP BY confusion**

You **cannot** mix aggregate functions with window columns unless you separate with a CTE.
Example: `SELECT dept_avg_salary, COUNT(*)` → invalid if dept_avg_salary is window-based.

---
