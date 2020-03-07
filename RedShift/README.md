
# RedShift

The following resources I have used to prepare for Big data certification.

#### Notes

- Columnar storage, ACID compliant DW
- Compression done automatically for each column
- null columns will return as raw for compression
- Zone Maps: Metadata of blocks; min and max of block data
- Sort column data to increase effectiveness of zone maps; use temporal column and do not use it on high cardinality column
- Sort key is not useful on small set of data
- Writing (1-10 rows) has similar cost to a larger write (~100000)
- Deletes use MVCC
- update is just a delete and re-insert at the end of table 
 
##### Architecture

- 1 Leader Node and several compute node in a cluster
- Leader node stores metadata and statistics
- Compute nodes maintain subset of data
- data is loaded in parallel and mirrored 
- storage of each node is divided into slices
- Each compute node has either 2, 16, or 32 slices of data
- Elastic and classic node resizing
- Elastic allows to add nodes to existing cluster while classic resize first place the existing cluster in read-only mode and creates and copy cluster to new confifiguration. Also, when elastic resize happens, all read & write queries are blocked or killed, if running.
- Node type only allows classic resize
- STL provide history of the system while STV has snapshot of current system data

##### Data Loading

- \# of vCPUs = \# of slices
- COPY command to populate data to table in RedShift. Command does automatic compression
	- if copy fails, all changes are rolled back 
	- COPY implicitly converts data to target data type
	- csv file with size from 1 MB to 1 GB after gzip compression
- Alternate method is data pipeline
- RDS sync
- With INSERT/UPDATE/DELETE (expensive) fragmentation can be done using VACUMM (sort, delete ..).
- RedShift cluster and S3 bucket must be in same region
- Read only access to S3 insert table
- struct, map, or array are not supported by redshift


##### Data Distribution

- Affects speed of joins and disk usage
- **Even:** default: round-robin distribution: Accessing all the data in a table pretty much all the time and not suitable for join.
	- Subset of data exists on each node
- **Key:** Suitable for performing **joins / group by performance** . Data might reside in a single compute node or same slide for quick quering.
	- Subset of data exists on each node
- **All:** Creates a copy of data on every single compute node. Slower to perform load, update, and insert. Preferred to use with small dimensions table

- Star Schema Design [Designating Distribution Styles](https://docs.aws.amazon.com/redshift/latest/dg/t_designating_distribution_styles.html)
	- Key for PK and FK
	- EVEN for denormalized and non-joined tables
	- All for lookup tables like catalog


##### Syntax

- recommendation is that all tables should be all lower case
- Highly recommended [RedShift Developers Guide](https://docs.amazonaws.cn/en_us/redshift/latest/dg/redshift-dg.pdf#welcome)
- No arrays in RedShift
- primary, distkey, compound sortkey (group by, order by), interleaved sort key (equal weight to each column or subset of columns)
- readratio parameter can only be used when copying DynamoDB. The value should be less than the average unused provisioned throughput
- Multirow-inserts row can be performed but copy is recommended.
- LOCKS are allowed.


##### Best Practices

- Avoid distribution key on temporal columns
- Always add compression to tables
- Add sort keys to which filter is being performed
- Turn the backup option off on staging data


## Labs

### Lab # 1 (Reference i)
The labs are from oreilly's AWS RedShift course by Rich Morrow. There were few configuration issues I faced while creating those labs.

 - Creating RedShift Cluster
	- Lunch VPC 2 node cluster
	- Update default VPC inbound rule to allow port (TCP:5439) for your own IP address
	- IAM user with full admin access
	- The lab has a different interface and to get connection details, check properties of a cluster
	- create snapshot

 - SQL Workbench
	- Install [SQL workbench](http://sql-workbench.eu/downloads.html)
	- Download RedShift JDBC [Drivers](https://docs.aws.amazon.com/redshift/latest/mgmt/configure-jdbc-connection.html#download-jdbc-driver)

	- **ERROR** I was not able to access redshift with sql workbench client as VPC would need Elastic IP address for cluster to be publically available. It seems like that option wasn't there while creating a cluster but it does exist under cluster properties. 
	
	- **Solution** Use query editor option by giving redshift user permission [AmazonRedshiftQueryEditor](https://docs.aws.amazon.com/redshift/latest/gsg/rs-gsg-connect-to-cluster.html)
	
	- March 7,2020: I was finally able to connect to redshift using SQL workbench. I downloaded drivers without sdk and I was able to create table, insert values, and query data. [Drivers](https://s3.amazonaws.com/redshift-downloads/drivers/jdbc/1.2.41.1065/RedshiftJDBC42-no-awssdk-1.2.41.1065.jar) can be downloaded from aws site. Please download the latest drivers.

 - [Tutorial Table Tunning Design](https://docs.aws.amazon.com/redshift/latest/dg/tutorial-loading-data.html)
	- Download sample data files
	- Upload to S3
	- Load data into RedShift
	
	- **ERROR** *[Amazon](500310) Invalid operation: S3ServiceException:The S3 bucket addressed by the query is in a different region from this cluster.,Status 301,Error PermanentRedirect* 
	
	- **Solution** Even though my cluter and bucket in the same region 'ca-central-1' but still would not copy load. I used arn instead of aws_access_key_id & aws_secret_access_key. Also, added region in the coopy command.
	
	- Load the part table
	copy part from 's3://BUCKET_NAME/part-csv.tbl'
	credentials 'aws_iam_role=arn:' 
	csv
	null as '\000'
	region 'ca-central-1';
	
	- Load table with csv file
	- Load table with tab formatted file (delimiter '\t')
	- Load table using manifest file / fixed width
	
 - 	Check pg_catalog for metadata
	- pg_catalog.stl_load_commits (query, slice, filename, status)
	- data distribution of a table
		- select * from pg_catalog.svv_diskusage where name='customer' and col = 0 order by slice, col
		num_values column shows number of values in each slot
	- Get table metadata like name, column, type, encoding, distribution and sort key, nullable
		- select * from pg_catalog.svv_diskusage where name='customer' and col = 0 order by slice, col


##### RedShift Spectrum Lab # 2 
The following labs are from oreilly's Frank and Stephane's course. The lab is to create Redshift cluster and create schema from glue catalog table.

- Create a security group within VPC
		- Add inboud rules for port 22 and 5439 and restrict it to your IP
- Create Role with AmazonS3ReadOnlyAccess and  AWSGlueConsoleFullAccess
- Create RedShift cluster **Instructions provided in previous lab**
- Create RedShift schema based on data catalog database

	*create external schema schema_name from data catalog database 'database_in_glue_catalog' iam_role 'your_IAM_role_arn' region 'ca-central-1';*

	- Query redshift table to view data that was brought from S3
		*select description, count(*) from schema_name.table_name where country = 'France' and year = '2020' and  month = '02' group by description;*

##### Lab # 3 (Reference ii)

- Create cluster using quick launch
- Create cluster using advanced settings

##### Lab # 4 (Amazon Redshift getting started guide)

- **Load Sample Data**
		- Create Table using [script](https://github.com/msheikh24/aws/blob/master/RedShift/lab3/queries/lab3-create-tables.sql)
		- Upload data to S3 bucket 
		- Load sample data from S3 to RedShift using [COPY command](https://github.com/msheikh24/aws/blob/master/RedShift/lab3/queries/lab3-load-s3data.sql)
		- metadata of tables is maintaied by PG_TABLE_DEF
		
- **ERROR** *[Amazon](500310) Invalid operation: syntax error at or near "SELECT" Position: 200;* 

- **Solution** It turns out that whenever I was selecting query within aws query editor, the error message could come up otherwise *Ctrl + Enter* works fine. Strange behaviour by editor.
- Perform [sample queries](https://github.com/msheikh24/aws/blob/master/RedShift/lab3/queries/lab3-select-queries.sql) to view data.

#### re:invent Videos

[Best Practices with Amazon RedShift](https://youtu.be/Hur-p3kGDTA)
[Best Practices for Scaling Amazon Redshift - AWS Online Tech Talks](https://youtu.be/QbOo78FGwnk) . This webinar was very helful in understanding basic concepts and elastic option in RedShift.

#### Articles


#### Reference
i. Learning Path: AWS RedShift by Rich Morrow (oreilly)

ii. AWS Certified Big Data - Specialty Complete Video Course by Robert Jordan, Chris Brousseau, Noah Gift (oreilly)

iii. [Getting Started With Amazon Redshift]([https://docs.aws.amazon.com/redshift/latest/gsg/getting-started.html)
