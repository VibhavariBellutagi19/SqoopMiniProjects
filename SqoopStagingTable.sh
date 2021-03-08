#!/bin/bash
#Title: SqoopStagingTable.sh
#Description: When Sqoop export fails while running, the data export will not be complete and only few records will be inserted in the mysql main table, which is not the right way. To handle such job failure, we have stagging tables.
#Author: Vibhavari B
#Creation date: 1/8/2021
#Run command: sh -x SqoopStagingTable.sh
#Parameters:
# This scripts takes runtime parameters
#Prerequisite: To perform stagging table, we need to have two tables in mysql - main table and staging table.
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

echo "Please enter table name"
read table_name
echo "Please enter hdfs export directory path"
read hdfs_export_path
echo "Please enter the stagging table name"
read stage_table_name
echo "Please enter the fields_terminated_by char"
read fields_terminated_by
echo "Please enter the lines_terminated_by char"
read lines_terminated_by
	   
echo "sqoop export \
-Dhadoop.security.credential.provider.path=$jceks_url \
--connect $connect_url \ 
--username $user_name \
--password $access_key \
--table $table_name \
--staging-table $stage_table_name \
--export-dir $hdfs_export_path \
--fields-terminated-by $fields_terminated_by \
--lines-terminated-by $lines_terminated_by"


sqoop export \
-Dhadoop.security.credential.provider.path=$jceks_url \
--connect $connect_url \ 
--username $user_name \
--password $access_key \
--table $table_name \
--staging-table $stage_table_name \
--export-dir $hdfs_export_path \
--fields-terminated-by $fields_terminated_by \
--lines-terminated-by $lines_terminated_by

echo "Script execution completed"

