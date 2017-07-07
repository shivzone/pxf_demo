#!/bin/bash

# download kafka
if [ ! -f kafka_2.11-0.11.0.0.tgz ]; then
	curl -O http://mirror.nexcess.net/apache/kafka/0.11.0.0/kafka_2.11-0.11.0.0.tgz
fi
tar -xvzf kafka_2.11-0.11.0.0.tgz
cd kafka_2.11-0.11.0.0

# start Zookeeper and Kafka zervers
bin/zookeeper-server-start.sh config/zookeeper.properties > /tmp/zookeeper.log 2>&1 &
bin/kafka-server-start.sh config/server.properties > /tmp/server.log 2>&1 &

TOPIC=iotstream

# create topic
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic $TOPIC
bin/kafka-topics.sh --list --zookeeper localhost:2181

#bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic $TOPIC --from-beginning