#!/bin/bash
DIR=kafka_2.11-0.11.0.0
TOPIC=iotstream
DELAY="${1:-3}"

./producer.sh $DELAY | $DIR/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic $TOPIC
