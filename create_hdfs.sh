#!/bin/bash
###########################
# HDFS file of the format:
#
# id (integer), 
# product_id (integer), 
# customer_id (integer),
# time (YYYY-MM-DD)
#
# where all fields are comma delimited.
#
###########################

# 1. create file with data
sh create_hdfs_file.sh

# 2. copy file to hdfs
hadoop fs -rm -r /pxf_demo
hadoop fs -mkdir /pxf_demo
hadoop fs -copyFromLocal `pwd`/transactions.csv /pxf_demo/.

# view data
hadoop fs -cat /pxf_demo/transactions.csv | head
hadoop fs -cat /pxf_demo/transactions.csv | wc


 
