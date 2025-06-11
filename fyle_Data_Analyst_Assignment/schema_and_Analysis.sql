-- Drop tables if they already exist to avoid conflicts
DROP TABLE IF EXISTS expense_policies;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS orgs;

-- 1. Organization metadata table
CREATE TABLE orgs (
    org_id INT PRIMARY KEY,
    org_name TEXT NOT NULL,
    domain TEXT
);

-- 2. Employee records and roles
CREATE TABLE employees (
    user_id INT PRIMARY KEY,
    org_id INT REFERENCES orgs(org_id),
    details JSONB,                 -- For name, email, etc.
    is_enabled BOOLEAN,
    roles TEXT[]                   -- PostgreSQL array type
);

-- 3. Expense transaction data
CREATE TABLE expenses (
    id INT PRIMARY KEY,
    employee_id INT,               -- Not enforcing FK since employee might be inactive/missing
    org_id INT REFERENCES orgs(org_id),
    amount NUMERIC(12,2),
    created_at DATE,
    source TEXT                    -- e.g., REIMBURSABLE or CORPORATE_CARD
);

-- 4. Expense policy definitions
CREATE TABLE expense_policies (
    id INT PRIMARY KEY,
    org_id INT REFERENCES orgs(org_id),
    policy_type TEXT,
    description TEXT
);


-- ============================================
-- Part 1: Real Organization Analysis Report
-- Author: [Krishna Pande]
-- Date: [2025-06-08]
-- Description: This script identifies real organizations,
-- counts corporate card transactions in March 2025,
-- lists admin users, calculates active users,
-- and checks expense policy status.
-- ============================================

-- CTE 1: Filter real organizations
WITH real_orgs AS (
  SELECT id, org_name
  FROM orgs
  WHERE org_name NOT ILIKE '%test%'
    AND org_name NOT ILIKE '%demo%'
    AND org_name NOT ILIKE '%fyle%'
    AND domain NOT ILIKE '%gmail.com%'
),

-- CTE 2: Corporate card expenses in March 2025
march_ccc_expenses AS (
  SELECT org_id, COUNT(*) AS no_of_expenses_in_march
  FROM expenses
  WHERE source = 'CORPORATE_CARD'
    AND created_at >= '2025-03-01'
    AND created_at < '2025-04-01'
  GROUP BY org_id
),

-- CTE 3: Admin users per org
admin_users AS (
  SELECT
    org_id,
    STRING_AGG(CAST(id AS TEXT), ',') AS admin_user_ids,
    STRING_AGG(details::json ->> 'email', ',') AS admin_emails
  FROM employee
  WHERE roles @> '{ADMIN}'
  GROUP BY org_id
),

-- CTE 4: Active users who made expenses in March 2025
active_users AS (
  SELECT e.org_id, COUNT(DISTINCT e.id) AS no_of_active_users
  FROM employee e
  JOIN expenses x ON e.id = x.employee_id
  WHERE (e.details::json ->> 'is_enabled') = 'true'
    AND x.created_at >= '2025-03-01'
    AND x.created_at <  '2025-04-01'
  GROUP BY e.org_id
),

-- CTE 5: Expense policies count per org
policy_info AS (
  SELECT
    org_id,
    COUNT(*) AS no_of_expense_policies_created,
    CASE
      WHEN COUNT(*) > 0 THEN 'Yes'
      ELSE 'No'
    END AS expense_policies_present
  FROM expenses_policies
  GROUP BY org_id
)

-- Final SELECT combining all metrics
SELECT
  ro.id AS org_id,
  ro.org_name,
  COALESCE(au.admin_user_ids, '') AS admin_user_ids,
  COALESCE(au.admin_emails, '') AS admin_emails,
  COALESCE(me.no_of_expenses_in_march, 0) AS no_of_expenses_in_march,
  COALESCE(pi.expense_policies_present, 'No') AS expense_policies_present,
  COALESCE(pi.no_of_expense_policies_created, 0) AS no_of_expense_policies_created,
  COALESCE(acu.no_of_active_users, 0) AS no_of_active_users
FROM real_orgs ro
LEFT JOIN march_ccc_expenses me ON ro.id = me.org_id
LEFT JOIN admin_users au ON ro.id = au.org_id
LEFT JOIN active_users acu ON ro.id = acu.org_id
LEFT JOIN policy_info pi ON ro.id = pi.org_id

