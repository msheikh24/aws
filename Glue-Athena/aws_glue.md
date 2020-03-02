
# AWS Glue / Athena
The following resources I have used to prepare for Big data certification.

## Labs
The labs are from oreilly's Frank and Stephane's course. There were few configuration issues I faced while creating those labs.

 - Create an AWS Glue crawler
	- Provide source type: Data store
	- S3 Location of data
	- Create an IAM role
	- Schedule: On demand
	- Crawler's output goes into a database so created a new database
	- Run the crawler for database/tables to be created/updated
	
##### Sample Athena Queries for lab

Please change the database name and table name as per exercise.

*SELECT count(*) FROM "database_name"."table_name";*

*select description, count(*) from "database_name"."table_name" where country = 'France' and year = '2020' and month = '02' group by description;*

*select year, month, day from  "database_name"."table_name"*

#### re:invent Videos

#### Articles

#### Reference
AWS Certified Big Data Specialty 2019 - In Depth and Hands On! by Frank Kane and Stephane Maarek
