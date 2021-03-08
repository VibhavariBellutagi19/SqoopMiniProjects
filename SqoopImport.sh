#!/bin/bash
#Title : SqoopImport.sh
#Description: This shell automates following sqoop commands with parameter - 
#	1)To Sqoop Import with --target-dir parameter
#	2)To Sqoop Import with --warehourse-dir parameter
#	3)To Sqoop Import with import-all-tables parameter 
# 	4)To Sqoop Import with --where parameter
# 	5)To Sqoop Import with boundary query vals
# 	6)To Sqoop Import with -num-mappers or -m parameter , to handle the number of mappers triggered
#	7)To Sqoop Import with --split-by parameter for table with no primary key
#	8)To Sqoop Import with delimiters
#	9)To sqoop Import with append parameter
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


echo "To Sqoop Import with --target-dir parameter, press 1"
echo "To Sqoop Import with --warehourse-dir parameter, press 2"
echo "To Sqoop Import with import-all-tables parameter, press 3"
echo "To Sqoop Import with --where parameter, press 4"
echo "To Sqoop Import with boundary query vals parameter, press 5"
echo "To Sqoop Import with -num-mappers or -m parameter, press 6"
echo "To Sqoop Import with split-by parameter for table with no primary key, press 7"
echo "To Sqoop Import with delimiters, press 8"
echo "To Sqoop Import with append parameter, press 9"

read input
case $input in
	1) echo "Please enter table name"
	   read table_name
	   echo "Please enter hdfs_target_path"
	   read hdfs_target_path
       
	   echo "sqoop import \
	   -Dhadoop.security.credential.provider.path=$jceks_url \
	   --connect $connect_url --username $user_name --password $access_key --table $table_name --target-dir $hdfs_target_path"
	   
	   sqoop import \
	   -Dhadoop.security.credential.provider.path=$jceks_url \
	   --connect $connect_url --username $user_name --password $access_key --table $table_name --target-dir $hdfs_target_path          
;;
	2) echo "Please enter table name"
	   read table_name
	   echo "Please enter the hdfs_target_path"
       read hdfs_target_path
	   
	   echo "sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name --warehouse-dir $hdfs_target_path"
	   
	  sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name --warehouse-dir $hdfs_target_path
;; 
	3) echo "please enter the hdfs_target_path"
	   read hdfs_target_path
	   
	   echo "sqoop import-all-tables --connect $connect_url --username $user_name --password $password --warehouse-dir $hdfs_target_path 1>$table_name.out 2>$table_name.err"
	   
	   sqoop import-all-tables \
	   -Dhadoop.security.credential.provider.path=$jceks_url \
	   --connect $connect_url --username $user_name --password $access_key --warehouse-dir $hdfs_target_path 1>$table_name.out 2>$table_name.err
	   
	   echo "check the logs create at - /home/cloudera/$table_name.out and /home/cloudera/$table_name.err"
;;
	4) echo "Please enter table name"
	   read table_name
	   echo "Please enter the hdfs_target_path"
       read hdfs_target_path
	   echo "Please enter the cloumn name, if more than one cloumns then use comma inbetween columns"
	   read cloumns
	   echo "Please enter the where conditions"
	   read where_conditions
	   
	   echo "sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --columns $cloumns \
	  --where $where_conditions \
	  --warehouse-dir $hdfs_target_path"
	   
	  sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --columns $cloumns \
	  --where $where_conditions \
	  --warehouse-dir $hdfs_target_path
;;  
	5) echo "Please enter table name"
	   read table_name
	   echo "Please enter the hdfs_target_path"
       read hdfs_target_path
	   echo "Please enter the boundary val query"
	   read boundary_val
	   
	   echo "sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --columns $cloumns \
	  --boundary-query $boundary_val \
	  --warehouse-dir $hdfs_target_path"
	   
	  sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --columns $cloumns \
	  --boundary-query $boundary_val \
	  --warehouse-dir $hdfs_target_path
;;  
	6) echo "Please enter table name"
	   read table_name
	   echo "Please enter the hdfs_target_path"
       read hdfs_target_path
	   echo "Please enter the number of mappers"
	   read mappers
	   
	   echo "sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --warehouse-dir $hdfs_target_path \
	  --num-mappers $mappers"
	   
	  sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --warehouse-dir $hdfs_target_path \
	  --num-mappers $mappers
;;	  
	7) echo "Please enter table name"
	   read table_name
	   echo "Please enter the hdfs_target_path"
       read hdfs_target_path
	   echo "Please enter the split-by column"
	   read split_by
	   
	   echo " sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --split-by $split_by \
	  --warehouse-dir $hdfs_target_path"
	   
	  sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --split-by $split_by \
	  --warehouse-dir $hdfs_target_path
;;	
	8) echo "Please enter table name"
	   read table_name
	   echo "Please enter the hdfs_target_path"
       read hdfs_target_path
	   echo "Please enter the fields_terminated_by char"
	   read fields_terminated_by
	   echo "Please enter the lines_terminated_by char"
	   read lines_terminated_by
	   
	   echo "sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --fields_terminated_by $fields_terminated_by \
	  --lines_terminated_by $lines_terminated_by \
	  --warehouse-dir $hdfs_target_path"
	   
	  sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --fields_terminated_by $fields_terminated_by \
	  --lines_terminated_by $lines_terminated_by \
	  --warehouse-dir $hdfs_target_path
;;
	9) echo "Please enter table name"
	   read table_name
	   echo "Please enter the hdfs_target_path"
       read hdfs_target_path
	   echo "Please enter the fields_terminated_by char"
	   read fields_terminated_by
	   echo "Please enter the lines_terminated_by char"
	   read lines_terminated_by
	   
	   echo "sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --fields_terminated_by $fields_terminated_by \
	  --lines_terminated_by $lines_terminated_by \
	  --warehouse-dir $hdfs_target_path \
	  --append"
	   
	  sqoop import \
	  -Dhadoop.security.credential.provider.path=$jceks_url \
	  --connect $connect_url --username $user_name --password $access_key --table $table_name \
	  --fields_terminated_by $fields_terminated_by \
	  --lines_terminated_by $lines_terminated_by \
	  --warehouse-dir $hdfs_target_path \
	  --append
esac

echo "Script execution completed"


