###########################
# Hive table, representing customers:
#
# id (integer), 
# first_name (text), 
# last_name (text), 
# address (text),
# city (text)
# partition by country (text)
#
###########################

# 1. create data file
# created by auto-generation fake data (fakenamegenerator.com)
# into customers.csv

# 2. create hive table
hive

# create schema
create schema demo;
use demo;

# create table without partitions 
drop table customers_raw;
create table customers_raw (
	customer_id int,
	first_name string,
	last_name string,
	address string,
	city string,
	country string )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

# load data to raw table
load data local inpath '/tmp/customers.csv' into table customers_raw;

# create table with partitions
drop table customers;
create table customers (
	customer_id int,
	first_name string,
	last_name string,
	address string,
	city string )
partitioned by (country string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

# allow dynamic partitions in hive 
SET hive.exec.dynamic.partition = true;

# allow default partitions in hive
SET hive.exec.dynamic.partition.mode = nonstrict;

# insert data into hive table with partitions
insert into table customers partition ( country) select * from customers_raw;

select * from customers;

# view data in hdfs
hdfs dfs -ls /hive/warehouse/demo.db/customers/






 
