import pandas as pd



data = {
    'id': [1, 2, 3],
    'name': ['Alice', 'Bob', 'Charlie'],
    'age': [30, 25, 35],
    'department': ['HR', 'IT', 'Finance']
}

df = pd.DataFrame(data)

print(df)

print(df[['name', 'age']])

print(df[df['age'] > 30])

print(df.head(2))

print(df['department'].value_counts())
print("------------")

departments = pd.DataFrame({
    'id': [1, 2, 3],
    'department_name': ['HR', 'Engineering', 'Finance']
})

merged_df = pd.merge(df, departments, left_on='department', right_on='department_name')
print(merged_df)
