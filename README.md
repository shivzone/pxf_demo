# Demo Instructions

## In Hadoop: 

1. 1 HDFS file
2. 1 HBase table 
3. 1 Hive table with partitions

## In HAWQ

1. Readable table for HDFS file
2. Readable table for HBase table
3. Readable table for Hive table

The queries:

Join between all 3 readable table and a local HAWQ table.
HBase table query with filter on text/int fields
Hive table query with filter on partition fields
Write the results into HDFS table

########################################
To create HDFS file and data:
```
sh create_hdfs.sh
```

## In Hive
To create Hive table and data:
```
hive -f create_hive.sql
```

View Hive table on HDFS:
```
hdfs dfs -ls /hive/warehouse/demo.db/customers/
```

## In HBase
To create HBase table and data:
```
sh create_hbase.sh
```

To create HAWQ tables:
```
createdb demo
psql -d demo -f create_hawq_tables.sql
```

To run queries via HAWQ:
```
psql -d demo -f queries.sql
```

