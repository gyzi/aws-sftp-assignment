# aws-sftp-ssignment
Lambda function to extract content "20 char only" from uploaded text files in sftp-server and then store content to dynamodb


## Function logic and flow
- From SFTP Transfer event get info
    - bucket_name
    - key which is textfiles "IAM only allow .txt"
    - sftp serverID which will be used as dynamodb table name
- Extract textfiles content read 20 character only
- Store extracted content and filename to dynamodb table
- Delete textfiles from s3 bucket 

## Requirements
| Name | info |
|------|---------|
| function | lambda_function |
| runtime | python3.9 |
| lambda_handler.zip | compressed source code lambda_handler.py |
| sftp_textfile | uploaded textfile value received/retrieved from transfer workflow event |
| bucket_name | directory/bucket name value received/retrieved from transfer workflow event |


## DynamoDB Table Outputs

| FileTag | FileName | FileContent | 
|------|-------------|-------------|
| a4b11ec63392d689fa1fd58676dddf3a | textfilename | extracted content 20|
