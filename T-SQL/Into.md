# T-SQL (Transact-SQL) Overview

T-SQL (Transact-SQL) is Microsoft's proprietary extension to SQL (Structured Query Language) used for interacting with SQL Server databases. It includes all SQL standard commands plus additional programming constructs.

## T-SQL Command Categories

### 1. Data Definition Language (DDL) Commands
- **CREATE**: Creates database objects (tables, views, procedures, etc.)
- **ALTER**: Modifies existing database objects
- **DROP**: Removes database objects
- **TRUNCATE**: Removes all records from a table
- **RENAME**: Changes the name of an object

### 2. Data Manipulation Language (DML) Commands
- **SELECT**: Retrieves data from database
- **INSERT**: Adds new records to a table
- **UPDATE**: Modifies existing records
- **DELETE**: Removes records from a table
- **MERGE**: Performs insert, update, or delete operations in a single statement

### 3. Data Control Language (DCL) Commands
- **GRANT**: Gives user access privileges
- **DENY**: Restricts user access
- **REVOKE**: Removes previously granted/denied permissions

### 4. Transaction Control Commands
- **BEGIN TRANSACTION**: Starts a transaction
- **COMMIT**: Saves transaction changes permanently
- **ROLLBACK**: Undoes transaction changes
- **SAVE TRANSACTION**: Sets a savepoint within a transaction

### 5. Advanced T-SQL Commands
- **DECLARE**: Defines variables
- **SET**: Assigns values to variables
- **EXECUTE/EXEC**: Runs stored procedures
- **WAITFOR**: Delays execution
- **TRY...CATCH**: Error handling
- **WITH (Common Table Expressions)**: Defines temporary result sets

### 6. Flow Control Commands
- **IF...ELSE**: Conditional execution
- **BEGIN...END**: Defines statement blocks
- **WHILE**: Loop construct
- **BREAK**: Exits a loop
- **CONTINUE**: Skips to next iteration
- **GOTO**: Jumps to a label
- **RETURN**: Exits unconditionally
- **CASE**: Conditional expression

### 7. System Functions
- **Aggregate functions**: SUM(), AVG(), COUNT(), MIN(), MAX()
- **Date functions**: GETDATE(), DATEADD(), DATEDIFF(), DATEPART()
- **String functions**: SUBSTRING(), CHARINDEX(), LEN(), UPPER(), LOWER()
- **Mathematical functions**: ABS(), ROUND(), RAND(), SQRT()
- **System functions**: @@IDENTITY, @@ROWCOUNT, @@ERROR, @@VERSION

### 8. Stored Procedure Commands
- **CREATE PROCEDURE**: Creates a stored procedure
- **ALTER PROCEDURE**: Modifies a stored procedure
- **DROP PROCEDURE**: Removes a stored procedure
- **SP_EXECUTESQL**: Executes dynamic SQL

### 9. Cursor Commands
- **DECLARE CURSOR**: Defines a cursor
- **OPEN**: Opens a cursor
- **FETCH**: Retrieves rows from a cursor
- **CLOSE**: Closes a cursor
- **DEALLOCATE**: Removes cursor reference

### 10. Index Commands
- **CREATE INDEX**: Creates an index
- **DROP INDEX**: Removes an index
- **CREATE CLUSTERED INDEX**: Creates clustered index
- **CREATE NONCLUSTERED INDEX**: Creates nonclustered index

### 11. Join Commands
- **INNER JOIN**: Returns matching rows
- **LEFT JOIN**: Returns all left table rows + matches
- **RIGHT JOIN**: Returns all right table rows + matches
- **FULL JOIN**: Returns all rows when there's a match
- **CROSS JOIN**: Cartesian product of tables

### 12. Security Commands
- **CREATE LOGIN**: Creates server login
- **CREATE USER**: Creates database user
- **ALTER LOGIN**: Modifies login
- **DROP LOGIN**: Removes login
- **EXECUTE AS**: Changes execution context

### 13. XML Commands
- **FOR XML**: Returns results as XML
- **OPENXML**: Provides XML document handle
- **XML Data Type Methods**: query(), value(), exist(), modify(), nodes()

### 14. JSON Commands (SQL Server 2016+)
- **FOR JSON**: Returns results as JSON
- **JSON_VALUE**: Extracts scalar value from JSON
- **JSON_QUERY**: Extracts object/array from JSON
- **JSON_MODIFY**: Updates JSON string
- **ISJSON**: Tests if string contains valid JSON

This list covers the major T-SQL commands, though there are many more specialized commands and options available in different versions of SQL Server.