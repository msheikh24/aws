copy users from 's3://<myBucket>/aws-getting-started/allusers_pipe.txt'
credentials 'aws_iam_role=<iam-role-arn>'
delimiter '|' region 'ca-central-1';

copy venue from 's3://<myBucket>/aws-getting-started/venue_pipe.txt'
credentials 'aws_iam_role=<iam-role-arn>'
delimiter '|' region 'ca-central-1';

copy category from 's3://<myBucket>/aws-getting-started/category_pipe.txt'
credentials 'aws_iam_role=<iam-role-arn>'
delimiter '|' region 'ca-central-1';

copy date from 's3://<myBucket>/aws-getting-started/date2008_pipe.txt'
credentials 'aws_iam_role=<iam-role-arn>'
delimiter '|' region 'ca-central-1';

copy event from 's3://<myBucket>/aws-getting-started/allevents_pipe.txt'
credentials 'aws_iam_role=<iam-role-arn>'
delimiter '|' timeformat 'YYYY-MM-DD HH:MI:SS' region 'ca-central-1';

copy listing from 's3://<myBucket>/aws-getting-started/listings_pipe.txt'
credentials 'aws_iam_role=<iam-role-arn>'
delimiter '|' region 'ca-central-1';

copy sales from 's3://<myBucket>/aws-getting-started/sales_tab.txt'
credentials 'aws_iam_role=<iam-role-arn>'
delimiter '\t' timeformat 'MM/DD/YYYY HH:MI:SS' region 'ca-central-1';