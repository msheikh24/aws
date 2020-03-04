
# Elasticsearch

The following resources I have used to prepare for Big data certification.

#### Notes

- open source elasticsearch for log analytics, full text search
- Kibana provides visulization
- Elasticsearch does not serve as a long term storage
- Elasticsearch can rotate index by hourly, weekly, daily
- it takes json data for search

#### Labs

The labs are from tech talk video:

1. Create amazon elasticsearch cluster

2. Create firehose delivery stream

3. Send data for Firehose
	- Data streams can be created using putRecord (single document) or putRecordsBatch (Multiple data records in a single api call)
	- use amazon kinesis data generator to send data
	- Visulize data in Kibana

4. Monitor Log Ingestion Pipeline

#### re:invent Videos

#### AWS Online Tech Talks

1. Real-Time Log Analytics using Amazon Kinesis and [Amazon Elasticsearch Service](https://youtu.be/NfkGpjrdy_Y)
#### Articles

#### Reference
AWS Certified Big Data Specialty 2019 - In Depth and Hands On! by Frank Kane and Stephane Maarek
