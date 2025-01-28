| **Data Constraint**        | **Definition**                                                                                           | **Examples**                                                                                             |
|----------------------------|-------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| **Data Type**              | Values must be of a certain type: date, number, percentage, Boolean, etc.                              | If the data type is a date, a single number like 30 would fail the constraint and be invalid.          |
| **Data Range**             | Values must fall between predefined maximum and minimum values                                         | If the data range is 10-20, a value of 30 would fail the constraint and be invalid.                   |
| **Mandatory**              | Values can’t be left blank or empty                                                                    | If age is mandatory, that value must be filled in.                                                    |
| **Unique**                 | Values can’t have a duplicate                                                                          | Two people can’t have the same mobile phone number within the same service area.                      |
| **Regular Expression (Regex) Patterns** | Values must match a prescribed pattern                                                                | A phone number must match ###-###-#### (no other characters allowed).                                |
| **Cross-field Validation** | Certain conditions for multiple fields must be satisfied                                              | Values are percentages, and values from multiple fields must add up to 100%.                         |
| **Primary Key**            | (Databases only) Value must be unique per column                                                      | A database table can’t have two rows with the same primary key value.                                |
| **Set-Membership**         | (Databases only) Values for a column must come from a set of discrete values                          | Value for a column must be set to Yes, No, or Not Applicable.                                        |
| **Foreign Key**            | (Databases only) Values for a column must be unique values coming from a column in another table       | In a U.S. taxpayer database, the State column must be a valid state or territory from a States table. |
| **Accuracy**               | The degree to which the data conforms to the actual entity being measured or described                | If values for zip codes are validated by street location, the accuracy of the data goes up.          |
| **Completeness**           | The degree to which the data contains all desired components or measures                              | If data for personal profiles required hair and eye color, and both are collected, the data is complete. |
| **Consistency**            | The degree to which the data is repeatable from different points of entry or collection               | If a customer has the same address in the sales and repair databases, the data is consistent.         |
| **Timeliness**             | Data must be available or updated within a specific timeframe                                         | Inventory records should be updated within an hour of a sale.                                        |
| **Validity**               | Data must meet the required criteria or standards                                                     | A product code must have 8 digits, starting with two letters and ending with six numbers.            |
| **Referential Integrity**  | Ensures relationships between tables remain consistent                                                | If a foreign key references a primary key, the primary key value must exist.                         |
| **Business Rules Compliance** | Data must adhere to specific business rules or policies                                              | Discounts cannot exceed 50% of the product price.                                                    |
| **Format**                 | Data must adhere to a predefined structure or layout                                                  | Date values must follow the format YYYY-MM-DD.                                                       |
| **Nullability**            | Defines whether a field can have a null value                                                         | In a user profile, the middle name field can be null, but the first name field cannot.               |


##### Clean data + alignment to business objective = accurate conclusions

##### Alignment to business objective + newly discovered variables + constraints = accurate conclusions 

This illustration is a decision tree showing four possible decisions to make in order to work around data issues

##### Want to calculate your margin of error? 
All you need is population size, confidence level, and sample size. In order to better understand this calculator, review these terms:

1. **Confidence level**: A percentage indicating how likely your sample accurately reflects the greater population 

2. **Population**: The total number you pull your sample from

3. **Sample**: A part of a population that is representative of the population

4. **Margin of error**: The maximum amount that the sample results are expected to differ from those of the actual population