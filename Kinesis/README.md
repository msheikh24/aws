
# Kinesis

The following resources I have used to prepare for Big data certification.

#### Notes

- Kinesis Streams, Kinesis Firehose, Kinesis Analytics
- Sources: clickstream, application logs, IoT
- CloudWatch logs are built on top of Kinesis Data Streams
- Kinesis agent

#### Labs



The labs are from Frank and Stephane's course. There were few configuration issues I faced while creating those labs.

1. Using EC2 instance generate server logs to Amazon Kinesis Firehose
 - Create a free-tier EC2 instance
 - Create firehose stream

  
The logs showed following error: 
*com.amazon.kinesis.streaming.agent.tailing.AsyncPublisher [ERROR] AsyncPublisher[fh:PurchaseLogs:/var/log/cadabra/**.log]:RecordBuffer(id=37,records=500,bytes=41933) Retriable send error (com.amazonaws.services.kinesisfirehose.model.ResourceNotFoundException: Firehose PurchaseLogs not found under account 1234. (Service: AmazonKinesisFirehose; Status Code: 400; Error Code: ResourceNotFoundException; Request ID: f605a5aa-b6e2-4c51-a0ce-44322d2b8531)). Will retry.*

**Resolution**

To resolve this issue, I added  firehose [endpoint](https://docs.amazonaws.cn/en_us/general/latest/gr/fh.html) to json file and it started sending data. In my case Endpoint was *firehose.ca-central-1.amazonaws.com*

Using EC2 instance generate server logs to Amazon DataStreams
 - Create a free-tier EC2 instance
 - Create Kinesis DataStreams

DynamoDB 

 - Use a consumer script to write to DynamoDB LogGenerator.py to create
   logs and kinesis agent will pick it up and then consumer script will
   read the json and write it to dynamoDB

AWS Lamda

 - IAM roles Add two roles to IAM user so lamda can read, AmazonKinesisReadOnlyAccess, and write to dynamoDB,
   AmazonDynamoDBFullAccess
 - Create lamda role using role created in 4.1
 - Issues from Kinesis data stream to Lamda

**Resolution**

 - I received errors like **"Function Failed"** and was having issues
   getting lamda to work. I attached *AWSLambdaKinesisExecutionRole* to
   IAM policy.  	 
   
 - In the given code of I wasn't able to access data
   *[base64.b64decode(record['kinesis']['data']) for record in event['Records']]* so I had to print out *record['kinesis']* to view
   
 - the record in cloudwatch 	 While I was making all those lamda changes
   and somehow identation was off for 1 of the line which I fixed and
   finally all records in stream came through

#### re:invent Videos

1. re:Invent 2019:  Building a streaming data platform with [Amazon Kinesis](https://youtu.be/TAkcRD6OxPw)

#### Articles

An interesting article which highlights issues when using different services especially [kinesis](https://medium.com/teamzerolabs/5-aws-services-you-should-avoid-f45111cc10cd)

#### Reference
AWS Certified Big Data Specialty 2019 - In Depth and Hands On! by Frank Kane and Stephane Maarek
