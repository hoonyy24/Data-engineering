# Start Docker containers in detached mode
docker-compose up -d

# Check all running and stopped containers
docker ps -a

# Stop and remove the Zookeeper container
docker stop zookeeper
docker rm zookeeper

# Create a Kafka topic named "weather"
kafka-topics --create --topic weather --bootstrap-server localhost:9092

# Start a Kafka producer to send messages to the "weather" topic
kafka-console-producer --bootstrap-server localhost:9092 --topic weather

# Start a Kafka consumer to read messages from the "weather" topic from the beginning
kafka-console-consumer --bootstrap-server localhost:9092 --topic weather --from-beginning

# Delete the "weather" topic
kafka-topics --delete --topic weather --bootstrap-server localhost:9092

# Exit Kafka producer (Press Ctrl + D)
Ctrl + D

# Kafka Consumer runs in an infinite loop, so it must be manually terminated (Press Ctrl + C)
Ctrl + C

# Check if the Kafka consumer is running
ps aux | grep kafka-console-consumer

# Forcefully terminate the Kafka consumer process using its process ID (PID)
kill -9 <PID>

# Exit the terminal session or Docker container
exit

# Access the Kafka container's terminal
docker exec -it kafka bash

# Create a Kafka topic named "bankbranch" with 2 partitions
kafka-topics --create --topic bankbranch --partitions 2 --bootstrap-server localhost:9092

# Start a Kafka producer to send messages to the "bankbranch" topic
kafka-console-producer --bootstrap-server localhost:9092 --topic bankbranch
# Then, enter messages manually

# Start a Kafka consumer to read messages from the "bankbranch" topic from the beginning
kafka-console-consumer --bootstrap-server localhost:9092 --topic bankbranch --from-beginning

# Start a Kafka producer with message key support
kafka-console-producer --bootstrap-server localhost:9092 --topic bankbranch --property parse.key=true --property key.separator=:
# Then, enter key-value messages (e.g., "1:{'atmid': 1, 'transid': 103}")

# Start a Kafka consumer to read messages with keys displayed
kafka-console-consumer --bootstrap-server localhost:9092 --topic bankbranch --from-beginning --property print.key=true --property key.separator=:

# Delete the "bankbranch" topic
kafka-topics --delete --topic bankbranch --bootstrap-server localhost:9092

# Check running Docker containers
docker ps

# Stop all running Docker containers
docker stop $(docker ps -q)
