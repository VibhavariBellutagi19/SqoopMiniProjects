# SqoopMiniProjects - Mini projects on sqoop tool.

Apache Sqoop is a BigData tool, designed to transfer the data from Hadoop to RDBMS and vice versa. Any RDBMS can be used like oracle,mysql etc. Sqoop can also connect with hive for the transfer of the data.

Apache Sqoop supports following fetures - 
  1)Full load - Sqoop Import(RDBMS to HDFS) and Sqoop Export(RDBMS to HDFS)
  2)Incremental load
  3)Parallelism - Import/Export
  4)Compression
  5)Security Integration
  6)Load data directly into Hive/Hbase

In this project, we are mainly focused on automating the sqoop commands using shell script. Sqoop Automation performs below operations - 
  1) SqoopImport.sh
  2) SqoopExport.sh
  3) SqoopIncremental.sh
  4) SqoopPasswordSecurityIntegration.sh
  5) SqoopJob.sh
  6) SqoopStagingTable.sh
  7) SqoopWithHive.sh

Prerequisite :- 1.Hadoop HDFS with SQOOP 2.MySQL Database with username:root
Datasets - Took the reference from - https://relational.fit.cvut.cz/dataset/Financial website.
