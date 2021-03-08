#!/bin/bash
#Title : SqoopWithHive.sh
#Description: This shell automates the sqoop export command 
#Authot: Vibhavari B
#Creation date: 1/17/2021
#Run command: sh -x SqoopExport.sh
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

echo "To create hive table based on database table(Mysql), press 1"
echo "To load data into hive table, press 2"
read input
case $input in
	1) echo "Please enter DB table name"
	   read table_name
	   echo "Please enter Hive table name"
	   read hive_table_name
	   echo "Please enter the fields terminated by delimiter character"
	   read fields_terminated_by
       
	   echo "sqoop export \
	   -Dhadoop.security.credential.provider.path=$jceks_url \
	   --connect $connect_url --username $user_name --password $access_key \
	   --table $table_name \
	   --export-dir $export_hdfs__path \
	   --fields-terminated-by $fields_terminated_by"
	   
	   sqoop create-hive-table \
	   -Dhadoop.security.credential.provider.path=$jceks_url \
	   --connect $connect_url --username $user_name --password $access_key \
	   --table $table_name \
	   --hive-table $hive_table_name \
	   --fields-terminated-by $fields_terminated_by

esac

echo "Script execution completed"