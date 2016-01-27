
-- create hdfs table (transactions)
DROP EXTERNAL TABLE IF EXISTS transactions;
CREATE EXTERNAL TABLE transactions (
	transaction_id integer,
	product_id integer,
	customer_id integer,
	day date )
LOCATION ('pxf://localhost:51200/pxf_demo/transactions.csv?PROFILE=HdfsTextSimple')
FORMAT 'CSV' (delimiter=',');

-- create hbase table (products)
DROP EXTERNAL TABLE IF EXISTS products;
CREATE EXTERNAL TABLE products (
	recordkey integer,
	"product:name" text,
	"product:price" integer,
	"category:name" text )
LOCATION ('pxf://localhost:51200/products?PROFILE=HBase')
FORMAT 'CUSTOM' (formatter='pxfwritable_import');

-- create hive table, partitioned by country (customers)
DROP EXTERNAL TABLE IF EXISTS customers;
CREATE EXTERNAL TABLE customers (
	customer_id integer,
	first_name text,
	last_name text,
	address text,
	city text,
	country text )
LOCATION ('pxf://localhost:51200/demo.customers?PROFILE=Hive')
FORMAT 'CUSTOM' (formatter='pxfwritable_import');





