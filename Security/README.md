
# Data Security

The following resources I have used to prepare for Big data certification.

#### Notes

##### Data Governance

- Data is managed as an asset and transformed into meaningful information
- Data governance goals can be met by using AWS compliance

##### AWS Shared Responsibility Model

- Infrastructure Model: EC2 instance: User is responsible for all security. It includes patching and everything else. EC2, EBS, VPC
- Contriner Model: AWS will provision everything for you e.g. RDS, EMR, RedShift. User is still responsible for configuring firewall
- Abstract Model: Serverless services: AWS is responsbile for everything except for user data e.g. S3, Glue, DynamoDB, SQS

##### IAM

- Follow principle of least privilege meaning provide users access to services only required for their job.
- Users: root user and IAM user; try to avoid root user unless required
- Groups: Collection of user objects
- Role: conceptually as users; temporary set of permission given to a user or service
	- Service Role: EC2 service role
	- Service-linked Role: Service will create the role for you; EMR, RedShift

##### Encryption

- Asymeetric: Data in transit
- Symmetric: Data at rest (Encrypt and Decrypt data)
- Public key is used to encrypt data and private key is used to decrypt data 
- Traffic to AWS is always encrypted
- Data at rest: cloud Hardware security module(HSM), KMS
- For single tenant key management: HSM is used

##### VPC

- Networking settings for amazon resources
- Security Group: Defines rules for network traffic / Firewall rules
- Internet access through internet gateway
- To access other services within aws use internet gateway or an endpoint

##### RedShift Security

- VPC security groups to control access to cluster
- Redshift can use HSM
- Create your own policy and attach to a role e.g. allow redshift access to particular bucket

## Labs


### Lab # 1


##### Lab # 2


#### re:invent Videos

#### Articles


#### Reference
i. AWS Certified Big Data - Specialty Complete Video Course by Robert Jordan, Chris Brousseau, Noah Gift (oreilly)

