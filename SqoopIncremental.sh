#!/bin/bash
#Title : SqoopIncremental.sh
#Description: Sqoop incremental import is used to import only newer rows from the periously-imported set of rows. This shell automates following sqoop commands with parameter - 
#	1)To Sqoop Import with --apend parameter
#	2)To Sqoop Import with --lastmodified parameter
#Authot: Vibhavari B
#Creation date: 1/5/2021
#Run command: sh -x SqoopImport.sh
#Parameters:
# This scripts takes runtime parameters
#=======================================================================================

application_conf_file="./application.conf"
source ./application.conf

if [ -f "$application_conf_file" ]
then
	echo "$application_conf_file found"
else
	echo "$application_conf_file not found"
fi

connect_url="jdbc:mysql://$host_name:$port/$database_name"
user_name=$user_name
access_key=$access_key

echo "*Append incremental mode* is used when data needs to be imported when new rows are continually being added with the increasing row id value. --check-column is the column where the row's id is being incremented. --last-value is used to specify the last row id value is inserted. To Sqoop Import incremental with --append parameter, press 1"
echo "*Last modified incremental mode* is used, when rows of the source table may be updated, and each such update will set the value of a last-modified column to the current timestamp. Rows where the check column holds a timestamp more recent than the timestamp specified with --last-value are imported. To Sqoop Import incremental with --lastmodified value parameter, press 2"

read input

case $input in
	1) echo "Please enter the table name"
		read $table_name
		echo "Please enter the hdfs target directory"
		read $hdfs_target_dir
		echo "Please enter the check-column value"
		read $check_column
		echo "Please enter the --last-value"
		read $last_value
	
		echo "sqoop-import \
		--connect $connect_url \
		--username $user_name \
		--password $password \
		--table $table_name \
		--warehouse-dir $hdfs_target_dir \
		--incremental append \
		--check-column $check_column \
		--last-value $last_value"
		
		sqoop-import \
		--connect $connect_url \
		--username $user_name \
		--password $password \
		--table $table_name \
		--warehouse-dir $hdfs_target_dir \
		--incremental append \
		--check-column $check_column \
		--last-value $last_value
	
	2) 
	echo "Please enter the table name"
	read $table_name
	echo "Please enter the hdfs target directory"
	read $hdfs_target_dir
	echo "Please enter the check-column value"
	read $check_column
	echo "Please enter the --last-value"
	read $last_value
	
	echo ""
	sqoop-import \
	--connect $connect_url \
	--username $user_name \
	--password $password \
	--table $table_name \
	--warehouse-dir $hdfs_target_dir \
	--incremental lastmodified \
	--check-column $check_column \
	--last-value $last_value
esac

echo "Script execution completed"