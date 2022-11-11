# aws-sftp-ssignment
Lambda function to transmited uploaded text files in sftp-server to ony first 20 charcture  

[[_TOC_]]

# Usage Instructions
- upload file to sftp server
- check cloudwatch lambda_function log-group
- check text file after been transformed 

## Requirements
| Name | info |
|------|---------|
| function | lambda_function |
| runtime | python3.9 |
| lambda_handler.zip | compressed source code lambda_handler.py |
| sftp_textfile | transfer workflow event retrieval for text file in sftp |
| bucket_name | transfer workflow event retrieval for directory/bucket name |


## Outputs

| Name | Description |
|------|-------------|
| transformed_object | text file with 20 char only |
