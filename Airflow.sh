# Step 1: Install WSL and Update Packages
echo " Installing WSL and required dependencies..."
wsl --install
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip python3-venv -y

# Step 2: Create Airflow Virtual Environment
echo " Setting up the Airflow environment..."
mkdir -p ~/airflow
cd ~/airflow
python3 -m venv airflow-env
source airflow-env/bin/activate

# Step 3: Install Apache Airflow
echo " Installing Apache Airflow..."
pip install --upgrade pip
pip install "apache-airflow==2.7.3" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.7.3/constraints-3.8.txt"

# Step 4: Set Environment Variables (Persistent)
echo " Configuring Airflow environment variables..."
export AIRFLOW_HOME=~/airflow
echo 'export AIRFLOW_HOME=~/airflow' >> ~/.bashrc
source ~/.bashrc

# Step 5: Initialize Airflow Database
echo " Initializing Airflow database..."
airflow db init

# Step 6: Create Airflow Admin User
echo " Creating an admin user for Airflow..."
airflow users create \
    --username admin \
    --password admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com

# Step 7: Start Airflow Webserver & Scheduler
echo " Starting Airflow services..."
airflow webserver --port 8080 -D
airflow scheduler -D

# Step 8: Create DAGs Directory and Open nano Editor for DAG Creation
echo " Setting up DAGs directory..."
mkdir -p ~/airflow/dags
nano ~/airflow/dags/my_first_etl_dag.py  # Open nano editor for DAG script

# Step 9: Check Running Airflow Processes
echo " Checking running Airflow processes..."
ps aux | grep airflow

echo " Apache Airflow installation and setup completed! 🎉"
echo " Access Airflow Web UI: http://localhost:8080"


