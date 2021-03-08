#!/bin/bash
#Title : SqoopExport.sh
#Description: This shell automates the sqoop export command 
#Authot: Vibhavari B
#Creation date: 1/10/2021
#Run command: sh -x SqoopExport.sh
#Parameters:
# This scripts takes runtime parameters
#Prerequisite: To run sqoop export command, the mysql table should be created and the data file, which needs to be export should be present in HDFS. 
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

echo "To Sqoop Export, press 1"
read input
case $input in
	1) echo "Please enter table name"
	   read table_name
	   echo "Please enter export_hdfs__path"
	   read export_hdfs__path
	   echo "Please enter the fields terminated by delimiter character"
	   read fields_terminated_by
       
	   echo "sqoop export \
	   -Dhadoop.security.credential.provider.path=$jceks_url \
	   --connect $connect_url --username $user_name --password $access_key \
	   --table $table_name \
	   --export-dir $export_hdfs__path \
	   --fields-terminated-by $fields_terminated_by"
	   
	   sqoop export \
	   -Dhadoop.security.credential.provider.path=$jceks_url \
	   --connect $connect_url --username $user_name --password $access_key \
	   --table $table_name \
	   --export-dir $export_hdfs__path \
	   --fields-terminated-by $fields_terminated_by

esac

echo "Script execution completed"
