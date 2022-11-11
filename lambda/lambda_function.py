import json
import boto3

s3_client = boto3.client("s3")

def lambda_handler(event, context):
    print(event['fileLocation']['bucket'])
    print(event['fileLocation']['key'])
    bucket_name = event['fileLocation']['bucket']
    sftp_textfile = event['fileLocation']['key']
    json_object =   s3_client.get_object(Bucket=bucket_name, Key=sftp_textfile)
    transformed_object  =   json_object['Body'].read(20)
    print(transformed_object)
    result = s3_client.put_object(Bucket=bucket_name, Key=sftp_textfile,Body=transformed_object)