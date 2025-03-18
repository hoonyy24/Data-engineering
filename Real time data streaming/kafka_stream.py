import uuid
from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator

# This DAG is responsible for streaming data to Kafka.
# Therefore, the following services must be running together.
# It determines which tasks should be executed and in what order.

default_args = {
    'owner': 'airscholar',
    'start_date': datetime(2025, 3, 18, 10, 00),
    'retries': 3,  # Retry up to 3 times in case of failure
    'retry_delay': timedelta(minutes=5),  # Retry after 5 minutes
    'depends_on_past': False,  # Execute regardless of past execution results
    'catchup': False  # Ignore past execution logs (run only from start_date onward)
}
# default_args is a dictionary defining default execution settings for the Apache Airflow DAG.
# It specifies properties such as the owner, start time, retry settings, etc., applied when the DAG runs.

def get_data():
    import requests

    results = requests.get("https://randomuser.me/api/")
    # Retrieves a <Response [200]> object
    results = results.json()
    results = results['results'][0]
    # Converts response to JSON and extracts data
    return results

def format_data(results):
    data = {}
    location = results['location']
    data['id'] = uuid.uuid4()
    # UUID is a standard method for generating unique IDs globally.
    data['first_name'] = results['name']['first']
    data['last_name'] = results['name']['last']
    data['gender'] = results['gender']
    data['address'] = f"{str(location['street']['number'])} {location['street']['name']}, " \
                      f"{location['city']}, {location['state']}, {location['country']}"
    data['post_code'] = location['postcode']
    data['email'] = results['email']
    data['username'] = results['login']['username']
    data['dob'] = results['dob']['date']
    data['registered_date'] = results['registered']['date']
    data['phone'] = results['phone']
    data['picture'] = results['picture']['medium']
    # The dictionary contains another nested dictionary
    return data

# 1. Create a Kafka Producer and connect to broker:29092
# 2. Stream random user data to the Kafka topic (users_created) for 60 seconds
# 3. Use the Airflow DAG (user_automation) to automate execution daily

def stream_data():
    import json
    from kafka import KafkaProducer
    import time
    import logging
    # Uses JSON to serialize data before sending to Kafka
    # Uses time to maintain streaming for a fixed duration
    # Uses logging to log errors if any occur

    producer = KafkaProducer(bootstrap_servers=['broker:29092'], max_block_ms=5000)
    curr_time = time.time()
    # Connects to Kafka Broker (broker:29092)
    # max_block_ms=5000: Waits up to 5 seconds before failing if the broker does not respond

    while True:
        if time.time() > curr_time + 60:  # Runs for 1 minute
            break
        try:
            results = get_data()
            results = format_data(results)
            # Removes unnecessary fields
            producer.send('users_created', json.dumps(results).encode('utf
