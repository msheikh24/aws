
# Elasticsearch

The following resources I have used to prepare for Big data certification.

#### Notes

- open source elasticsearch for log analytics, full text search
- Kibana provides visulization
- Elasticsearch does not serve as a long term storage
- Elasticsearch can rotate index by hourly, weekly, daily
- it takes json data for search
- database is called domain in elasticsearch

#### Labs

##### Lab # 1: Near real-time log analysis

Server logs will be generated from EC2 instance to Amazon Kinesis firehose and finally to Amazon Elasticsearch.

- Create an EC2 instance
	- install kinesis agent
	*sudo yum install -y aws-kinesis-agent*
	- Download log servers from site
	*wget http://media.sundog-soft.com/AWSBigData/httpd.zip*
	- move httpd directory to /var/log/httpd
	*mv httpd /var/log/httpd*
- Create Elasticsearch domain
- Create Firehose delivery stream
- Tie delivery streams to elasticsearch instance
	- update the /etc/aws-kinesis/agent.json with:
		- "firehose.endpoint"
		- "awsAccessKeyId"
		- "awsSecretAccessKey"
		- "filePattern": location of logs
		- "deliveryStream": name of stream
		- "initialPosition": start of file
- start the kinesis agent
	*service aws-kinesis-agent restart*
- View the logs to check if streams have started
- In elasticsearch, allow access to your IP
- Indices section will show the count of logs that have been received by firehose
- The logs can be viewed and visulize in kibana link under overview section

##### Lab # 2: Near real-time log analysis
This lab is pretty much same as lab 1 but could be useful as it was done in tech talk video:

- Create amazon elasticsearch cluster
- Create firehose delivery stream
- Send data for Firehose
	- Data streams can be created using putRecord (single document) or putRecordsBatch (Multiple data records in a single api call)
	- use amazon kinesis data generator to send data
	- Visulize data in Kibana

- Monitor Log Ingestion Pipeline

#### re:invent Videos

#### AWS Online Tech Talks

1. Real-Time Log Analytics using Amazon Kinesis and [Amazon Elasticsearch Service](https://youtu.be/NfkGpjrdy_Y)
#### Articles

#### Reference
AWS Certified Big Data Specialty 2019 - In Depth and Hands On! by Frank Kane and Stephane Maarek
