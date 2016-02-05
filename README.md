# Demo Instructions
## Prerequsites
1. Hdfs, Hive, HBase setup
2. HAWQ/PXF (https://github.com/apache/incubator-hawq) setup

## Tables

1. 1 HDFS file (transaction data)
2. 1 HBase table (product data)
3. 1 Hive table with partitions (customer data)

## In HDFS
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

## In HAWQ

1. Readable table for HDFS file
2. Readable table for HBase table
3. Readable table for Hive table
4. Writable table for HDFS file

To create HAWQ tables:
```
createdb demo
psql -d demo -f create_hawq_tables.sql
```

Join between all 3 readable table and a local HAWQ table.
HBase table query with filter on text/int fields
Hive table query with filter on partition fields
Write the results into HDFS table

To run queries via HAWQ:

Top 5 products of a specific country (Demonstrates querying against Hdfs,Hive & HBase with predicate push down to Hive) 
```
SELECT count(*) AS number_of_purchases, products."product:name"
FROM products, customers, transactions
WHERE products.recordkey = transactions.product_id
AND   customers.customer_id = transactions.customer_id
AND   customers.country = 'Belgium'
GROUP BY products."product:name"
ORDER BY number_of_purchases DESC
LIMIT 5;
```

Top 5 Customers by revenue, who bought items below 50$ (Demonstrates querying against Hdfs,Hive & HBase with predicate push down to HBase)
```
SELECT customers.first_name|| ' ' || customers.last_name as customer_name, SUM(products."product:price") as revenue
FROM products, customers, transactions
WHERE products.recordkey = transactions.product_id
AND   customers.customer_id = transactions.customer_id
AND   products."product:price" < 50
GROUP BY customers.customer_id, customers.first_name, customers.last_name
ORDER BY revenue DESC
LIMIT 5;
```

Total spend per customer. Result written to HDFS via writable table (Query Hdfs,Hive & HBase and write back join query results back to Hdfs)

```
INSERT INTO customer_spend
SELECT customers.first_name|| ' ' || customers.last_name as customer_name, SUM(products."product:price") as revenue
FROM products, customers, transactions
WHERE products.recordkey = transactions.product_id
AND   customers.customer_id = transactions.customer_id
GROUP BY customers.customer_id, customers.first_name, customers.last_name
ORDER BY revenue DESC;
```

Check output on HDFS
```
hadoop fs -cat /pxf_demo/customer_spend/*
```
