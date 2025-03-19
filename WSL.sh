# Step 1: Install WSL and Update Packages
wsl --install
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip python3-venv -y

# Step 2: Create Airflow Virtual Environment
mkdir -p ~/airflow
cd ~/airflow
python3 -m venv airflow-env
source airflow-env/bin/activate

# Step 3: Install Apache Airflow
pip install --upgrade pip
pip install "apache-airflow==2.7.3" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.7.3/constraints-3.8.txt"

# Step 4: Set Environment Variables (Persistent)
export AIRFLOW_HOME=~/airflow
echo 'export AIRFLOW_HOME=~/airflow' >> ~/.bashrc
source ~/.bashrc

# Step 5: Initialize Airflow Database
airflow db init

# Step 6: Create Airflow Admin User
airflow users create \
    --username admin \
    --password admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com

# Step 7: Start Airflow Webserver & Scheduler
airflow webserver --port 8080 -D
airflow scheduler -D

# Step 8: Create DAGs Directory and Open nano Editor for DAG Creation
mkdir -p ~/airflow/dags
nano ~/airflow/dags/my_first_etl_dag.py  # Open nano editor for DAG script

# Step 9: Check Running Airflow Processes
ps aux | grep airflow
pkill -f "airflow webserver"
pkill -f "airflow scheduler"
pkill -f airflow

cd ~/airflow
source airflow-env/bin/activate
ls ~/airflow/airflow-env
echo $AIRFLOW_HOME
airflow scheduler
airflow webserver -D
airflow scheduler -D

sudo rm -r script

#JAVA installation
sudo apt update && sudo apt install openjdk-11-jdk -y

#JAVA find the java installation path
readlink -f $(which java)

# Open the bash profile configuration file:
nano ~/.bashrc 

# Add the following lines at the bottom of the file:
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Apply the changes:
source ~/.bashrc 

# Verify that JAVA_HOME is set correctly:
echo $JAVA_HOME


