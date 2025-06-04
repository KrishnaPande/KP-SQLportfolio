You're asking for "all functions of VBA," which is an incredibly vast request. VBA has hundreds, if not thousands, of built-in functions, methods, and properties across its core language and the object models of various Office applications (Excel, Word, Access, etc.). Listing every single one with syntax and a complete description would be an entire book!

Instead, I'll categorize the most commonly used and important types of VBA functions and provide examples with their syntax and a brief explanation. This will give you a solid foundation for understanding the breadth of VBA's capabilities.

**Key Categories of VBA Functions:**

1.  **String Functions:** For manipulating text.
2.  **Numeric/Math Functions:** For calculations.
3.  **Date and Time Functions:** For working with dates and times.
4.  **Conversion Functions:** For changing data types.
5.  **Information Functions:** For checking data types, object states, etc.
6.  **File System Functions:** For interacting with files and folders.
7.  **Input/Output Functions:** For user interaction and debugging.
8.  **Array Functions:** For working with arrays.
9.  **Object-Specific Functions (Excel Examples):** Functions/methods specific to application objects.
10. **User-Defined Functions (UDFs):** How to create your own.

---

### 1. String Functions

These functions are used for manipulating and analyzing text strings.

* **`Len(string)`**
    * **Purpose:** Returns the number of characters in a string.
    * **Syntax:** `Dim length As Long: length = Len("Hello World")`
    * **Result:** `11`

* **`Left(string, length)`**
    * **Purpose:** Returns a specified number of characters from the left side of a string.
    * **Syntax:** `Dim subStr As String: subStr = Left("Excel VBA", 5)`
    * **Result:** `"Excel"`

* **`Right(string, length)`**
    * **Purpose:** Returns a specified number of characters from the right side of a string.
    * **Syntax:** `Dim subStr As String: subStr = Right("Excel VBA", 3)`
    * **Result:** `"VBA"`

* **`Mid(string, start, [length])`**
    * **Purpose:** Returns a specified number of characters from a string, starting at a specified position.
    * **Syntax:** `Dim subStr As String: subStr = Mid("Visual Basic", 8, 5)`
    * **Result:** `"Basic"`

* **`InStr([start], string1, string2, [compare])`**
    * **Purpose:** Returns the starting position of the first occurrence of one string within another.
    * **Syntax:** `Dim pos As Long: pos = InStr("Hello World", "World")`
    * **Result:** `7`

* **`Replace(expression, find, replace, [start], [count], [compare])`**
    * **Purpose:** Returns a string in which a specified substring has been replaced with another substring a specified number of times.
    * **Syntax:** `Dim newStr As String: newStr = Replace("Hello World", "World", "VBA")`
    * **Result:** `"Hello VBA"`

* **`UCase(string)` / `LCase(string)`**
    * **Purpose:** Converts a string to uppercase/lowercase.
    * **Syntax:**
        * `Dim upperStr As String: upperStr = UCase("hello")` -> `"HELLO"`
        * `Dim lowerStr As String: lowerStr = LCase("WORLD")` -> `"world"`

* **`Trim(string)` / `LTrim(string)` / `RTrim(string)`**
    * **Purpose:** Removes leading, trailing, or both leading and trailing spaces from a string.
    * **Syntax:**
        * `Dim trimmedStr As String: trimmedStr = Trim("  Hello  ")` -> `"Hello"`
        * `trimmedStr = LTrim("  Hello")` -> `"Hello"`
        * `trimmedStr = RTrim("Hello  ")` -> `"Hello"`

* **`Format(expression, [format])`**
    * **Purpose:** Returns a formatted string based on a specified format expression. Highly versatile for numbers, dates, and strings.
    * **Syntax:**
        * `Dim formattedNum As String: formattedNum = Format(12345.678, "##,##0.00")` -> `"12,345.68"`
        * `Dim formattedDate As String: formattedDate = Format(Now, "yyyy-mm-dd hh:nn:ss")` -> `"2025-06-04 00:03:47"` (example for current time)

---

### 2. Numeric/Math Functions

These functions perform mathematical calculations.

* **`Abs(number)`**
    * **Purpose:** Returns the absolute value of a number.
    * **Syntax:** `Dim result As Double: result = Abs(-10.5)`
    * **Result:** `10.5`

* **`Int(number)` / `Fix(number)`**
    * **Purpose:** Returns the integer portion of a number. `Int` rounds down for negative numbers, `Fix` truncates.
    * **Syntax:**
        * `Dim i As Long: i = Int(3.7)` -> `3`
        * `i = Int(-3.7)` -> `-4`
        * `i = Fix(3.7)` -> `3`
        * `i = Fix(-3.7)` -> `-3`

* **`Round(expression, [numdecimalplaces])`**
    * **Purpose:** Rounds a number to a specified number of decimal places. (Uses "round half to even" rule for .5)
    * **Syntax:** `Dim r As Double: r = Round(3.5)` -> `4`, `r = Round(2.5)` -> `2`
    * `r = Round(3.14159, 2)` -> `3.14`

* **`Sqr(number)`**
    * **Purpose:** Returns the square root of a number.
    * **Syntax:** `Dim s As Double: s = Sqr(25)`
    * **Result:** `5`

* **`Log(number)`**
    * **Purpose:** Returns the natural logarithm of a number.
    * **Syntax:** `Dim l As Double: l = Log(10)`

* **`Exp(number)`**
    * **Purpose:** Returns `e` (the base of natural logarithms) raised to a power.
    * **Syntax:** `Dim e As Double: e = Exp(1)` (approximately 2.71828)

* **`Rnd([number])`**
    * **Purpose:** Returns a random single-precision number between 0 and 1. Use `Randomize` to initialize the random number generator.
    * **Syntax:**
        * `Randomize`
        * `Dim rNum As Single: rNum = Rnd()`

---

### 3. Date and Time Functions

These functions are used for working with dates and times.

* **`Now()`**
    * **Purpose:** Returns the current system date and time.
    * **Syntax:** `Dim currentDateTime As Date: currentDateTime = Now()`
    * **Result:** e.g., `6/4/2025 12:03:47 AM`

* **`Date()`**
    * **Purpose:** Returns the current system date.
    * **Syntax:** `Dim currentDate As Date: currentDate = Date()`
    * **Result:** e.g., `6/4/2025`

* **`Time()`**
    * **Purpose:** Returns the current system time.
    * **Syntax:** `Dim currentTime As Date: currentTime = Time()`
    * **Result:** e.g., `12:03:47 AM`

* **`Year(date)` / `Month(date)` / `Day(date)` / `Hour(time)` / `Minute(time)` / `Second(time)`**
    * **Purpose:** Extracts parts of a date/time.
    * **Syntax:**
        * `Dim y As Integer: y = Year(Now())`
        * `Dim m As Integer: m = Month(Now())`
        * `Dim d As Integer: d = Day(Now())`
        * `Dim h As Integer: h = Hour(Now())`
        * `Dim min As Integer: min = Minute(Now())`
        * `Dim s As Integer: s = Second(Now())`

* **`Weekday(date, [firstdayofweek])`**
    * **Purpose:** Returns a number representing the day of the week (1 for Sunday, 2 for Monday, etc.).
    * **Syntax:** `Dim wd As Integer: wd = Weekday(Now())`

* **`DateSerial(year, month, day)`**
    * **Purpose:** Returns a Date value for a specified year, month, and day. Useful for constructing dates.
    * **Syntax:** `Dim myDate As Date: myDate = DateSerial(2025, 12, 25)`

* **`TimeSerial(hour, minute, second)`**
    * **Purpose:** Returns a Date value for a specified hour, minute, and second. Useful for constructing times.
    * **Syntax:** `Dim myTime As Date: myTime = TimeSerial(9, 30, 0)`

* **`DateAdd(interval, number, date)`**
    * **Purpose:** Adds a specified time interval to a date.
    * **Intervals:** "yyyy" (year), "q" (quarter), "m" (month), "y" (day of year), "d" (day), "w" (weekday), "ww" (week), "h" (hour), "n" (minute), "s" (second).
    * **Syntax:** `Dim futureDate As Date: futureDate = DateAdd("d", 7, Date())` (Adds 7 days to today)

* **`DateDiff(interval, date1, date2, [firstdayofweek], [firstweekofyear])`**
    * **Purpose:** Returns the number of time intervals between two dates.
    * **Syntax:** `Dim daysDiff As Long: daysDiff = DateDiff("d", #1/1/2025#, Date())` (Days since Jan 1, 2025)

---

### 4. Conversion Functions

These functions convert data from one type to another.

* **`CStr(expression)`**
    * **Purpose:** Converts an expression to a String.
    * **Syntax:** `Dim s As String: s = CStr(123)`

* **`CInt(expression)` / `CLng(expression)`**
    * **Purpose:** Converts an expression to an Integer / Long.
    * **Syntax:**
        * `Dim i As Integer: i = CInt(123.45)` -> `123`
        * `Dim l As Long: l = CLng("100000")`

* **`CDbl(expression)` / `CSng(expression)`**
    * **Purpose:** Converts an expression to a Double / Single.
    * **Syntax:**
        * `Dim d As Double: d = CDbl("3.14159")`
        * `Dim s As Single: s = CSng(12.34)`

* **`CDate(expression)`**
    * **Purpose:** Converts an expression to a Date.
    * **Syntax:** `Dim myDate As Date: myDate = CDate("2025-06-04")`

* **`CBool(expression)`**
    * **Purpose:** Converts an expression to a Boolean. (0 is False, any non-zero is True)
    * **Syntax:** `Dim b As Boolean: b = CBool(1)` -> `True`

* **`CVar(expression)`**
    * **Purpose:** Converts an expression to a Variant (the default data type in VBA if not specified).
    * **Syntax:** `Dim v As Variant: v = CVar(True)`

---

### 5. Information Functions

These functions provide information about data types, variables, and objects.

* **`IsEmpty(expression)`**
    * **Purpose:** Returns `True` if a variable has not been initialized. Only works for Variant types.
    * **Syntax:** `Dim v As Variant: Debug.Print IsEmpty(v)` -> `True`

* **`IsNull(expression)`**
    * **Purpose:** Returns `True` if an expression contains no valid data (e.g., from a database field).
    * **Syntax:** `Dim v As Variant: v = DBField: Debug.Print IsNull(v)` (If DBField is Null)

* **`IsNumeric(expression)`**
    * **Purpose:** Returns `True` if an expression can be evaluated as a number.
    * **Syntax:** `Dim b As Boolean: b = IsNumeric("123")` -> `True`

* **`IsDate(expression)`**
    * **Purpose:** Returns `True` if an expression can be converted to a date.
    * **Syntax:** `Dim b As Boolean: b = IsDate("2025-01-01")` -> `True`

* **`IsObject(expression)`**
    * **Purpose:** Returns `True` if an expression refers to a valid object.
    * **Syntax:** `Dim ws As Worksheet: Set ws = ThisWorkbook.Sheets(1): Debug.Print IsObject(ws)` -> `True`

* **`TypeName(expression)`**
    * **Purpose:** Returns a string indicating the data type of a variable.
    * **Syntax:** `Dim i As Integer: Debug.Print TypeName(i)` -> `"Integer"`

---

### 6. File System Functions (VBA.FileSystem)

These functions interact with the file system. Requires `Microsoft Scripting Runtime` reference for more advanced file operations (e.g., `FileSystemObject`).

* **`Dir(pathname, [attributes])`**
    * **Purpose:** Returns the name of a file or directory that matches a specified pattern. Useful for iterating files.
    * **Syntax:** `Dim fileName As String: fileName = Dir("C:\MyFolder\*.txt")` (Gets the first .txt file)

* **`Kill(pathname)`**
    * **Purpose:** Deletes a specified file.
    * **Syntax:** `Kill "C:\MyFolder\OldFile.txt"`

* **`FileCopy(source, destination)`**
    * **Purpose:** Copies a file.
    * **Syntax:** `FileCopy "C:\Source.txt", "C:\Destination.txt"`

* **`MkDir(path)`**
    * **Purpose:** Creates a new directory.
    * **Syntax:** `MkDir "C:\NewFolder"`

* **`RmDir(path)`**
    * **Purpose:** Removes an empty directory.
    * **Syntax:** `RmDir "C:\EmptyFolder"`

---

### 7. Input/Output Functions

These functions facilitate user interaction and debugging.

* **`MsgBox(prompt, [buttons], [title], [helpfile], [context])`**
    * **Purpose:** Displays a message box and optionally waits for user input (e.g., OK, Cancel).
    * **Syntax:**
        * `MsgBox "Operation Complete!"`
        * `Dim response As VbMsgBoxResult: response = MsgBox("Continue?", vbYesNo + vbQuestion, "Confirm")`

* **`InputBox(prompt, [title], [default], [xpos], [ypos], [helpfile], [context])`**
    * **Purpose:** Displays a dialog box prompting the user for input.
    * **Syntax:** `Dim userName As String: userName = InputBox("Enter your name:", "User Input")`

* **`Debug.Print expression`**
    * **Purpose:** Prints the value of an expression to the Immediate window in the VBE. Crucial for debugging.
    * **Syntax:** `Debug.Print "Value of x: " & x`

---

### 8. Array Functions

These functions are used for manipulating arrays.

* **`UBound(arrayname, [dimension])` / `LBound(arrayname, [dimension])`**
    * **Purpose:** Returns the upper/lower bound of a specified dimension of an array.
    * **Syntax:**
        * `Dim myArray(1 To 10) As Integer`
        * `Debug.Print UBound(myArray)` -> `10`
        * `Debug.Print LBound(myArray)` -> `1`
        * For 2D array: `Dim arr(1 to 5, 1 to 3)`. `UBound(arr, 1)` is 5, `UBound(arr, 2)` is 3.

* **`Array(arg1, arg2, ...)`**
    * **Purpose:** Creates an array from a list of arguments. Returns a Variant containing an array.
    * **Syntax:** `Dim myVariantArray As Variant: myVariantArray = Array("Apple", "Banana", "Cherry")`

* **`Split(expression, [delimiter], [limit], [compare])`**
    * **Purpose:** Returns a zero-based one-dimensional array containing a specified number of substrings.
    * **Syntax:** `Dim parts() As String: parts = Split("One,Two,Three", ",")`
    * **Result:** `parts(0)` = "One", `parts(1)` = "Two", `parts(2)` = "Three"

* **`Join(sourcearray, [delimiter])`**
    * **Purpose:** Returns a string created by joining the elements of an array.
    * **Syntax:** `Dim combinedString As String: combinedString = Join(parts, "-")`
    * **Result:** `"One-Two-Three"`

---

### 9. Object-Specific Functions/Methods (Excel Examples)

These are methods (actions an object can perform) and properties (attributes of an object) that you interact with using objects from the application's object model. They aren't standalone functions but are fundamental to VBA's power.

* **`Range.Select()`**
    * **Purpose:** Selects a range of cells.
    * **Syntax:** `Worksheets("Sheet1").Range("A1").Select`

* **`Range.Value`** (Property, not a function, but crucial for data access)
    * **Purpose:** Gets or sets the value of a cell or range.
    * **Syntax:**
        * `Dim cellValue As Variant: cellValue = Range("A1").Value`
        * `Range("B1").Value = "Hello"`

* **`Worksheet.Cells(row, column)`**
    * **Purpose:** Returns a `Range` object representing a cell.
    * **Syntax:** `Worksheets("Sheet1").Cells(1, 1).Value = "First Cell"`

* **`Workbook.Save()`**
    * **Purpose:** Saves the workbook.
    * **Syntax:** `ThisWorkbook.Save`

* **`Workbook.Close([SaveChanges], [Filename], [RouteWorkbook])`**
    * **Purpose:** Closes the workbook.
    * **Syntax:** `ThisWorkbook.Close SaveChanges:=True`

* **`Application.WorksheetFunction.FunctionName(...)`**
    * **Purpose:** Allows you to use many of Excel's built-in worksheet functions directly in VBA.
    * **Syntax:** `Dim total As Double: total = Application.WorksheetFunction.Sum(Range("A1:A10"))`

---

### 10. User-Defined Functions (UDFs)

You can create your own functions in a standard module to perform custom calculations or operations. These can be called from other VBA procedures or directly from worksheet cells.

* **Syntax:**

    ```vba
    Function MyCustomFunction(parameter1 As DataType, Optional parameter2 As DataType = DefaultValue) As ReturnDataType
        ' Your code here
        ' Perform calculations, manipulate objects, etc.
        MyCustomFunction = result_of_calculation ' Assign the return value
    End Function
    ```

* **Example (Simple UDF):**

    ```vba
    Function AddTwoNumbers(num1 As Double, num2 As Double) As Double
        AddTwoNumbers = num1 + num2
    End Function
    ```

    * **Usage in VBA:** `Dim sumResult As Double: sumResult = AddTwoNumbers(5, 3)`
    * **Usage in Excel Cell:** `=AddTwoNumbers(A1, B1)`

* **Example (UDF with Range Input):**

    ```vba
    Function CountNonEmptyCells(inputRange As Range) As Long
        Dim cell As Range
        Dim count As Long
        count = 0
        For Each cell In inputRange
            If Not IsEmpty(cell.Value) And Not IsNull(cell.Value) And cell.Value <> "" Then
                count = count + 1
            End If
        Next cell
        CountNonEmptyCells = count
    End Function
    ```

    * **Usage in Excel Cell:** `=CountNonEmptyCells(A1:C10)`

---

This overview covers the most frequently encountered and powerful functions and concepts in VBA. To truly master "all functions," you would need to explore the specific object models for each Office application (Excel, Word, Access, Outlook, PowerPoint, etc.), as each has its own unique set of objects, methods, and properties that extend VBA's capabilities significantly. The best way to discover them is through the **VBA Object Browser** (F2 in the VBE) and the **Microsoft documentation**.