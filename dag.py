from datetime import timedelta
import requests
import json
import csv

from airflow.models import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago

API_URL = "https://jsonplaceholder.typicode.com/users"

# Define output file paths
EXTRACTED_FILE = "/tmp/extracted_data.json"
TRANSFORMED_FILE = "/tmp/transformed_data.csv"

# Extract Function: Fetch data from API and save as JSON
def extract():
    print("Extracting data from API...")
    response = requests.get(API_URL)
    if response.status_code == 200:
        with open(EXTRACTED_FILE, "w") as file:
            json.dump(response.json(), file)
        print("Data extracted successfully!")
    else:
        raise Exception("Failed to fetch data from API")

# Transform Function: Convert JSON data to CSV
def transform():
    print("Transforming data to CSV format...")
    with open(EXTRACTED_FILE, "r") as infile, open(TRANSFORMED_FILE, "w", newline="") as outfile:
        data = json.load(infile)
        writer = csv.writer(outfile)
        
        # Write header
        writer.writerow(["id", "name", "email", "city"])
        
        # Write user data
        for user in data:
            writer.writerow([user["id"], user["name"], user["email"], user["address"]["city"]])
        
        print("Data transformed successfully!")

# Load Function: Print transformed data
def load():
    print("Loading data...")
    with open(TRANSFORMED_FILE, "r") as file:
        print(file.read())
    print("Data loaded successfully!")

# Airflow DAG Default Arguments
default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define DAG
dag = DAG(
    'api_etl_dag',
    default_args=default_args,
    description='An ETL DAG that extracts data from an API, transforms it, and loads it',
    schedule_interval=timedelta(days=1),
)

# Define Tasks
extract_task = PythonOperator(
    task_id='extract',
    python_callable=extract,
    dag=dag,
)

transform_task = PythonOperator(
    task_id='transform',
    python_callable=transform,
    dag=dag,
)

load_task = PythonOperator(
    task_id='load',
    python_callable=load,
    dag=dag,
)

# Set Task Dependencies
extract_task >> transform_task >> load_task
