# PXF Kafka Connector 

Contains PXF connector (fragmenter, accessor and resolver) to enable PXF access to Kafka stream

```DemoKafkaAccessor``` is respnsible to read data from configured topic in chunks of records
The data is sent back as a chunk of CSV which would lazily be resolved in the SQL engine.

## Table DDL
```
create external table kafkatest (sensor_id int, temperature int, time text)
location ('pxf://localhost:51200/kafkatest1|office-4-24.pa.pivotal.io|iotstream'
'?FRAGMENTER=org.apache.hawq.pxf.api.examples.DemoKafkaFragmenter'
'&ACCESSOR=org.apache.hawq.pxf.api.examples.DemoKafkaAccessor'
'&RESOLVER=org.apache.hawq.pxf.plugins.hdfs.StringPassResolver')
FORMAT 'TEXT' (DELIMITER = ',');
```
