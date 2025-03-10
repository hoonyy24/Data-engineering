echo Hello, Linux!

echo $env:AIRFLOW_HOME

airflow db init
airflow webserver --port 8080
airflow scheduler

airflow dags list
