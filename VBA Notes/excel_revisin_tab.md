Here’s a **quick revision of Excel functions** with **1-line explanations**, **1-line examples**, and **clarity on when to select a range vs single cell**, crafted for someone who knows **Pandas and SQL well**:

| **Function**          | **Purpose (1-line)**                                                | **Example (1-line)**                           | **Range or Single?**                      |
| --------------------- | ------------------------------------------------------------------- | ---------------------------------------------- | ----------------------------------------- |
| `SUM`                 | Adds numbers in a range.                                            | `=SUM(A1:A5)`                                  | Range                                     |
| `AVERAGE`             | Returns the average of values.                                      | `=AVERAGE(B2:B10)`                             | Range                                     |
| `COUNT`               | Counts numeric values.                                              | `=COUNT(C1:C10)`                               | Range                                     |
| `COUNTA`              | Counts non-empty cells.                                             | `=COUNTA(A1:A10)`                              | Range                                     |
| `IF`                  | Performs logic test and returns value based on result.              | `=IF(A1>10, "High", "Low")`                    | Single value (condition), others optional |
| `IFS`                 | Multiple conditions without nesting.                                | `=IFS(A1<10,"Low",A1<20,"Mid",TRUE,"High")`    | Single value per condition                |
| `SUMIF`               | Sum values based on single condition.                               | `=SUMIF(A1:A10, ">10", B1:B10)`                | Range                                     |
| `SUMIFS`              | Sum values based on multiple conditions.                            | `=SUMIFS(C1:C10, A1:A10, ">10", B1:B10, "<5")` | Range                                     |
| `COUNTIF`             | Count cells matching a condition.                                   | `=COUNTIF(A1:A10, "=Yes")`                     | Range                                     |
| `COUNTIFS`            | Count cells matching multiple conditions.                           | `=COUNTIFS(A:A,">10",B:B,"Yes")`               | Range                                     |
| `VLOOKUP`             | Finds value in 1st column of range and returns value from same row. | `=VLOOKUP(101, A2:C10, 2, FALSE)`              | Range table + single lookup value         |
| `XLOOKUP`             | Flexible lookup in any direction (modern version).                  | `=XLOOKUP(101, A:A, B:B)`                      | Range                                     |
| `HLOOKUP`             | Same as VLOOKUP but searches horizontally.                          | `=HLOOKUP("Jan", A1:Z2, 2, FALSE)`             | Range                                     |
| `INDEX`               | Returns value at specific row & column in range.                    | `=INDEX(A1:C3, 2, 1)`                          | Range                                     |
| `MATCH`               | Returns position of a value in a range.                             | `=MATCH(50, A1:A10, 0)`                        | Range                                     |
| `INDEX-MATCH`         | Combo used to lookup values more flexibly than VLOOKUP.             | `=INDEX(B1:B10, MATCH(101, A1:A10, 0))`        | Range                                     |
| `LEFT`                | Extracts N characters from start of text.                           | `=LEFT(A1, 4)`                                 | Single value (cell)                       |
| `RIGHT`               | Extracts N characters from end.                                     | `=RIGHT(A1, 3)`                                | Single value (cell)                       |
| `MID`                 | Extracts substring from specific position.                          | `=MID(A1, 2, 3)`                               | Single value (cell)                       |
| `LEN`                 | Returns character count.                                            | `=LEN(A1)`                                     | Single value (cell)                       |
| `TRIM`                | Removes extra spaces.                                               | `=TRIM(A1)`                                    | Single value (cell)                       |
| `CONCAT` / `TEXTJOIN` | Joins text from multiple cells.                                     | `=TEXTJOIN(" ", TRUE, A1:A3)`                  | Range or list                             |
| `TEXT`                | Formats number/date into text.                                      | `=TEXT(A1, "dd-mmm-yyyy")`                     | Single value                              |
| `NOW`                 | Returns current date & time.                                        | `=NOW()`                                       | No range                                  |
| `TODAY`               | Returns current date.                                               | `=TODAY()`                                     | No range                                  |
| `PROPER`              | Capitalizes first letter of each word.                              | `=PROPER(A1)`                                  | Single value                              |
| `UPPER`               | Converts text to uppercase.                                         | `=UPPER(A1)`                                   | Single value                              |
| `LOWER`               | Converts text to lowercase.                                         | `=LOWER(A1)`                                   | Single value                              |
| `ROUND`               | Rounds number to given decimals.                                    | `=ROUND(A1, 2)`                                | Single value                              |
| `ROUNDUP`             | Always rounds up.                                                   | `=ROUNDUP(A1, 1)`                              | Single value                              |
| `ROUNDDOWN`           | Always rounds down.                                                 | `=ROUNDDOWN(A1, 1)`                            | Single value                              |
| `RANK`                | Ranks a number in a list.                                           | `=RANK(A1, A1:A10)`                            | Single + Range                            |
| `ISBLANK`             | Checks if cell is empty.                                            | `=ISBLANK(A1)`                                 | Single value                              |
| `ISNUMBER`            | Checks if cell is number.                                           | `=ISNUMBER(A1)`                                | Single value                              |
| `IFERROR`             | Returns alternate value if formula errors.                          | `=IFERROR(A1/B1, "Error")`                     | Single value                              |
| `FILTER`              | Filters array based on condition. (Excel 365+)                      | `=FILTER(A1:A10, B1:B10="Yes")`                | Range                                     |
| `UNIQUE`              | Returns unique values from range. (Excel 365+)                      | `=UNIQUE(A1:A10)`                              | Range                                     |
| `SORT`                | Sorts range. (Excel 365+)                                           | `=SORT(A1:A10)`                                | Range                                     |
| `TRANSPOSE`           | Switches rows to columns and vice versa.                            | `=TRANSPOSE(A1:C3)`                            | Range                                     |
| `SUBTOTAL`            | Performs function like SUM/COUNT while ignoring hidden rows.        | `=SUBTOTAL(9, A1:A10)`                         | Range                                     |

---

### 🔍 Quick Tip:

* **Use Range** when you're applying a function to **multiple cells** (e.g., `SUM(A1:A5)`).
* **Use Single Cell** when referencing or checking **a specific cell value** (e.g., `IF(A1>0, ...)`).

Let me know if you want this as an Excel sheet or a printable PDF.
