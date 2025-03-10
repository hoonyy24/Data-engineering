echo Hello, Linux!

wsl --install

#필수 패키지 업데이트 및 설치
sudo apt update
sudo apt upgrade -y
sudo apt install python3 python3-pip python3-venv -y

#Airflow wjsdyd 가상환경 생
mkdir ~/airflow
cd ~/airflow
python3 -m venv airflow-env
source airflow-env/bin/activate

#Airflow 설치
pip install "apache-airflow==2.7.3" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.7.3/constraints-3.8.txt"

#환경 변수 설정
export AIRFLOW_HOME=~/airflow

Airflow 데이터베이스 초기화
airflow db init

#Airflow 웹 서버 실행
airflow webserver --port 8080

Airflow 스케줄러 실행
airflow scheduler

#password reset
wsl -u root

#passwd username

exit

#sudo apt install python3 python3-pip python3-venv -y


setx AIRFLOW_HOME "C:\Airflow"
echo $env:AIRFLOW_HOME
$env:AIRFLOW_HOME="C:\Airflow" 만약 powershell을 시작했는데도 airflow_home이 인식되지 않는다면 가상환경 내에서 직접 환경변수를 설정해야합니


airflow_home을 가상환 경내에서 영구적으로 설정하는 방법 
cd C:\Airflow\myenv
notepad Scripts\activate.bat
set AIRFLOW_HOME=C:\Airflow(파일 맨 아래에 추가)
myenv\Scirpts\activate
echo $env:AIRFLOW_HOME


airflow db init
airflow webserver --port 8080
airflow scheduler

airflow dags list
airflow dags trigger my-first-python-etl-dag
