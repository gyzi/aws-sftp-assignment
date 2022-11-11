# aws-sftp-ssignment
Lambda function to transmited uploaded text files in sftp-server to ony first 20 charcture  


## Usage Instructions
- upload file to sftp server
- check cloudwatch lambda_function log-group
- check text file after been transformed 

## Requirements
| Name | info |
|------|---------|
| function | lambda_function |
| runtime | python3.9 |
| lambda_handler.zip | compressed source code lambda_handler.py |
| sftp_textfile | uploaded textfile value received/retrieved from transfer workflow event |
| bucket_name | directory/bucket name value received/retrieved from transfer workflow event |


## Outputs

| Name | Description |
|------|-------------|
| transformed_object | text file with 20 char only |
