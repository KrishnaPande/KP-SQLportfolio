# Python ETL Pipeline Example

Here's a complete example of a simple ETL pipeline in Python using common libraries. This pipeline extracts data from a CSV file and a REST API, transforms it, and loads it into a SQLite database.

## 1. Setup Required Libraries

```bash
pip install pandas requests sqlalchemy
```

## 2. ETL Pipeline Code

```python
import pandas as pd
import requests
from sqlalchemy import create_engine
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def extract():
    """Extract data from different sources"""
    logger.info("Starting extraction")
    
    # Extract data from CSV
    try:
        csv_data = pd.read_csv('sales_data.csv')
        logger.info(f"Extracted {len(csv_data)} records from CSV")
    except FileNotFoundError:
        logger.error("CSV file not found")
        csv_data = pd.DataFrame()
    
    # Extract data from API
    try:
        response = requests.get('https://api.example.com/products', timeout=10)
        response.raise_for_status()
        api_data = pd.DataFrame(response.json())
        logger.info(f"Extracted {len(api_data)} records from API")
    except requests.exceptions.RequestException as e:
        logger.error(f"API request failed: {e}")
        api_data = pd.DataFrame()
    
    return {'csv_data': csv_data, 'api_data': api_data}

def transform(extracted_data):
    """Transform and join the extracted data"""
    logger.info("Starting transformation")
    
    csv_data = extracted_data['csv_data']
    api_data = extracted_data['api_data']
    
    # Basic data cleaning
    if not csv_data.empty:
        # Handle missing values
        csv_data.fillna({'discount': 0}, inplace=True)
        
        # Convert date column to datetime
        csv_data['sale_date'] = pd.to_datetime(csv_data['sale_date'])
        
        # Calculate total price
        csv_data['total_price'] = csv_data['quantity'] * (csv_data['unit_price'] - csv_data['discount'])
    
    # Join data if both sources are available
    if not csv_data.empty and not api_data.empty:
        transformed_data = pd.merge(
            csv_data,
            api_data[['product_id', 'category', 'weight']],
            on='product_id',
            how='left'
        )
    else:
        transformed_data = csv_data if not csv_data.empty else api_data
    
    # Add processing timestamp
    transformed_data['etl_processed_at'] = datetime.now()
    
    logger.info(f"Transformed data shape: {transformed_data.shape}")
    return transformed_data

def load(transformed_data, db_file='etl_database.db'):
    """Load data into SQLite database"""
    logger.info("Starting load")
    
    if transformed_data.empty:
        logger.warning("No data to load")
        return
    
    try:
        engine = create_engine(f'sqlite:///{db_file}')
        transformed_data.to_sql(
            'sales_records',
            engine,
            if_exists='append',
            index=False
        )
        logger.info(f"Successfully loaded {len(transformed_data)} records to database")
    except Exception as e:
        logger.error(f"Failed to load data: {e}")

def run_etl_pipeline():
    """Run the complete ETL pipeline"""
    logger.info("ETL pipeline started")
    
    # Execute ETL steps
    extracted_data = extract()
    transformed_data = transform(extracted_data)
    load(transformed_data)
    
    logger.info("ETL pipeline completed")

if __name__ == '__main__':
    run_etl_pipeline()
```

## 3. Sample Input Files

**sales_data.csv** (example content):
```
product_id,quantity,unit_price,discount,sale_date
101,2,19.99,2.0,2023-01-15
102,1,49.99,0.0,2023-01-16
103,3,9.99,1.0,2023-01-17
```

## 4. Key Components Explained

1. **Extract**:
   - Reads from a CSV file using pandas
   - Fetches data from a REST API using requests
   - Handles errors gracefully

2. **Transform**:
   - Cleans data (handles missing values)
   - Performs calculations (total price)
   - Joins data from different sources
   - Adds metadata (processing timestamp)

3. **Load**:
   - Uses SQLAlchemy for database operations
   - Appends data to existing tables
   - Handles database connection errors

## 5. Enhancements You Could Add

- Add data validation checks
- Implement incremental loading
- Add error recovery mechanisms
- Parallelize operations for better performance
- Add unit tests
- Containerize with Docker
- Schedule with Airflow

Would you like me to elaborate on any of these enhancements or explain a specific part in more detail?