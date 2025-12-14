# Snowflake and dbt Seeds — Comprehensive Learnings and Notes

## 1. Snowflake File Handling

- **Direct file access from your computer is NOT possible in Snowflake.**
  - You must **upload files** (such as CSV/TXT) to a "stage" (a special storage area in Snowflake, like your user stage).
- **Types of stages:**
  - **User Stage (`@~`)** — personal file area for your user
  - **Table Stage (`@%TABLE_NAME`)** — associated with a table
  - **Named/Internal/External Stages** — can point to cloud storage (AWS S3, Azure, GCP)
- **How to upload files in Snowflake:**
  - Use the web UI (Snowsight/Data > Stages OR Classic Worksheets > Files/Upload).
  - After upload, file is available in the stage (`@~/filename.csv`).

## 2. Checking Files in your Stage

- **Command to see files in your user stage:**
  ```sql
  LIST @~;
  ```
  - This lists all available files in your personal stage and verifies upload success.

## 3. Setting Database and Schema

- Before creating tables, always **set your database and schema:**
  ```sql
  USE DATABASE your_database_name;
  USE SCHEMA your_schema_name;
  ```
  - This ensures all SQL statements know where to store new tables.

## 4. Creating Temporary Tables

- **Temporary tables** are session-scoped and auto-delete after logout.
  - Common for staging/uploading intermediate data:
    ```sql
    CREATE OR REPLACE TEMPORARY TABLE temp_item_ids (item_id VARCHAR);
    ```
  - Use `VARCHAR` for IDs for flexibility (large numbers, future format changes).

## 5. Loading Data From Stage

- **COPY INTO** is used to load data from a staged file to a table:
  ```sql
  COPY INTO temp_item_ids
  FROM @~/item_ids.csv
  FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1); -- If CSV has header
  ```
  - Use `SKIP_HEADER = 0` if your CSV/TXT does NOT have a header.

## 6. Common Error Solutions

- **“0 files processed” error:**  
  - Usually means the file isn't uploaded, path is wrong, or stage is incorrect.  
  - Run `LIST @~;` to check what files are available.
- **“Session does not have a current database” error:**  
  - Set your database and schema using the `USE DATABASE`/`USE SCHEMA` commands.

## 7. File Types

- **CSV (Comma Separated):**  
  - Best for tables; include a header for clarity and easier loading.
- **TXT (Plain Text):**  
  - Good for single-column lists; less structured, sometimes needs custom file format.

## 8. dbt Seeds — Easy Local Data Loads

- **dbt seeds** allow you to use **local CSV files** (placed in the `/seeds` folder of your dbt project) and create actual tables in Snowflake.
- When you run:
  ```sh
  dbt seed
  ```
  - dbt will upload and create a table from each CSV in `/seeds`.
- You don’t need to manually stage or upload files; dbt manages it.
- Seed tables can be referenced in dbt models via `{{ ref('seed_table_name') }}`.

## 9. dbt File Structure

- When you initialize dbt, you get a folder structure:
  ```
  dbt_project/
    ├─ models/
    ├─ seeds/
    ├─ snapshots/
    ├─ analyses/
    ├─ tests/
    └─ dbt_project.yml
  ```
- Place your seed files (CSV) in the `/seeds` directory.

## 10. Best Practices / Tips

- Prefer **CSV with headers** for smoother database loads.
- Always set your database/schema before running CREATE or COPY statements.
- Use `VARCHAR` for IDs unless you're certain all values are integers.
- dbt seeds are ideal for lightweight, version-controlled data loading in analytics workflows.
- For large or frequently changing files, prefer Snowflake stage uploads; for team workflow/scenario, dbt seeds are simplest.

---

**Summary:**  
In Snowflake, you upload files to a stage, then load them into tables with SQL. Always set your database/schema, check your stage for file uploads, and use CSVs for easiest integration. dbt’s seeds make it super easy to turn local CSVs into Snowflake tables for analytics—no manual staging needed!
---
We created and did researching when for first triage ticket which we are working on