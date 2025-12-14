# Quick corrections, rules, and memory checklist (straight to the point)

Nice work — you’re nearly there. Below I fix your expressions, explain the small-but-critical syntax details, show how to add defaults and handle NULL/text, and give a compact checklist you can paste into your `.md`.

---

## Corrected expressions (copy-paste ready)

1. Running SUM of `amount` ordered by `txn_date` (safe, precise):

```
SUM(amount) OVER (ORDER BY txn_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
```

2. Running AVG of `score` ordered by `score_date`:

```
AVG(score) OVER (ORDER BY score_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
```

3. First `price` by `updated_at` (true first across all rows):

```
FIRST_VALUE(price) OVER (ORDER BY updated_at ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
```

4. Last `rating` by `rated_at` (true last across all rows):

```
LAST_VALUE(rating) OVER (ORDER BY rated_at ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
```

5. 2nd value of `amount` ordered by `txn_date` (NTH_VALUE):

```
NTH_VALUE(amount, 2) OVER (ORDER BY txn_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
```

> Note: most engines don’t accept a “default” inside `NTH_VALUE`. Use `COALESCE(...)` to supply a fallback (see below).

6. `status` 2 rows behind, with default `'no_history'`, partitioned by `user_id`:

```
LAG(status, 2, 'no_history') OVER (PARTITION BY user_id ORDER BY login_time)
```

7. Next `status` with default `'none'`:

```
LEAD(status, 1, 'none') OVER (ORDER BY some_order_col)
```

> **Important:** `OVER` is **mandatory**. If you omit `OVER(...)`, the function is invalid — SQL won’t implicitly use table order. You must provide an `ORDER BY` inside `OVER` when using LEAD/LAG for relative rows.

8. Row number ordered by `created_at`:

```
ROW_NUMBER() OVER (ORDER BY created_at)
```

> `ROW_NUMBER()` is never “empty” — it will always return a number per row. If you omit `ORDER BY`, the order is implementation-defined (effectively arbitrary).

---

## Defaults and NULL handling — practical rules

* **LAG / LEAD**: accept a third argument as **default**: `LAG(col, offset, default)`.
* **NTH_VALUE**: most dialects do **not** accept a default param. Use `COALESCE(NTH_VALUE(...), <default>)` to return fallback.
* **Aggregates (SUM, AVG, MIN, MAX)**: ignore `NULL`s by default (i.e., they skip NULL rows). If all inputs are NULL, result is NULL — wrap with `COALESCE(...)`.
* **Text columns**: window functions like `FIRST_VALUE`, `LAST_VALUE`, `LAG`, `LEAD`, `NTH_VALUE` work on text. Aggregates (SUM/AVG) don’t work on text.
* **To force fallback when result NULL**:

  ```
  COALESCE(NTH_VALUE(col, 2) OVER (...), 'default_text')
  ```
* **IGNORE NULLS / RESPECT NULLS**: some DBs (Oracle, BigQuery, Postgres via extensions) support `FIRST_VALUE(... ) IGNORE NULLS` or similar — use if available to skip NULLs when finding first/last. If not supported, combine with `FILTER` or use `ROW_NUMBER()` over a filtered partition.

---

## Why `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` every time for running calculations

* `ORDER BY` alone defaults to `RANGE` in many DBs → ties (duplicate order values) get grouped, breaking row-by-row running totals.
* `ROWS` gives **precise row-by-row control**, predictable across engines. Memorize: **ROWS = precise; RANGE = grouping by ties**.

---

## Extra alternate methods & gotchas (handy to store)

* Running totals via cumulative **SUM() OVER (ORDER BY ...)** with explicit `ROWS` is the portable way.
* Alternate (less efficient) method: `SUM(...)` via a self-join or correlated subquery (useful if your engine lacks good window support).
* To restart running totals per group: add `PARTITION BY` before `ORDER BY`.

  ```
  SUM(x) OVER (PARTITION BY product_id ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
  ```
* `FIRST_VALUE`/`LAST_VALUE` without framing returns the first/last within the frame — be explicit if you need “whole partition” semantics.
* If `ORDER BY` column has duplicates and you need deterministic order, include more columns in ORDER BY (e.g., timestamp + id).
* `ROW_NUMBER`, `RANK`, `DENSE_RANK`: know the difference. `ROW_NUMBER()` never ties, `RANK()` produces gaps, `DENSE_RANK()` does not produce gaps.

---

## Tiny memory checklist (copy into your `.md`)

* Always include `OVER(...)` for window funcs.
* For running aggs, always use: `OVER (ORDER BY <col> ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`.
* Use `PARTITION BY` when you want groups.
* Use `LAG/LEAD(col, offset, default)` — third arg = default.
* For NTH_VALUE fallback → `COALESCE(NTH_VALUE(...), default)`.
* Wrap aggregates with `COALESCE(..., default)` if you need non-NULL results.
* Prefer `ROWS` over `RANGE` for running per-row behavior.
* If ordering has duplicates, add tiebreaker: `ORDER BY date, id`.
* `FIRST_VALUE` / `LAST_VALUE` need full-frame to be stable across rows if you want the partition-wide first/last.

---

## Final practice instruction (do this)

1. Copy the **Corrected expressions** section to your `.md`.
2. Add the **Tiny memory checklist** below each expression.
3. Practice by writing 10 variants: change `partition by`, offsets (2,3), text defaults, and order tie-breakers.

When you want, I’ll generate 12 rapid-fire variants from Set A but including these gotchas (NTH_VALUE fallback, IGNORE NULLS, duplicated order values). Say “drill me with gotchas” and I’ll fire them.
