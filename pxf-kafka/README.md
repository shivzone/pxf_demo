# PXF Kafka Connector 

Contains PXF connector (fragmenter, accessor and resolver) to enable PXF access to Kafka stream

```DemoKafkaAccessor``` is responsible to read data from configured topic in chunks of records
The data is sent back as a chunk of CSV(multiple records from the Kafka stream) which would lazily be resolved in the SQL engine.
As long as CSV data format is used, TEXT formatter should be used when external GPDB/HAWQ table is being created.

## Usage
### Setup Kafka Producer
```
./setup-kafka.sh
```
1. Downloads kafka and starts kafka and zookeeper servers.
2. Create Kafka topic (eg: iostream is used as the topic name by default)

### Start Kafka Producer
```
./iostream.sh
```
Runs the kafka-console-producer on port 9092. This periodicaly produces data on the kafka stream

### HAWQ External Table
You will need to create an external table in HAWQ which uses the kafka plugin in order to fetch data
As part of the location in the SQL DDL the user will need to provide the following ```pxf://<pxf_host>:<pxf_port>/<consumer_group>|<kafka server address>|<kafka topic>```

Example DDL 
```
create external table kafkatest (sensor_id int, temperature int, time text)
location ('pxf://localhost:51200/kafkatest1|office-4-24.pa.pivotal.io|iotstream'
'?FRAGMENTER=org.apache.hawq.pxf.api.examples.DemoKafkaFragmenter'
'&ACCESSOR=org.apache.hawq.pxf.api.examples.DemoKafkaAccessor'
'&RESOLVER=org.apache.hawq.pxf.plugins.hdfs.StringPassResolver')
FORMAT 'TEXT' (DELIMITER = ',');
```

Query table
```
select sensor_id, avg(temperature), min(temperature), max(temperature), count(1) as "Number of samples", max(time) as "Latest sample" from kafkatest group by sensor_id order by 1;
```
