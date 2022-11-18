import json
import boto3

s3_client = boto3.client("s3")
dynamo_client = boto3.client('dynamodb')

def lambda_handler(event, context):
    #get bucket and key name from s3 upload event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    sftp_textfile = event['Records'][0]['s3']['object']['key']
    try:
        #extract textfile content and decode as str 
        json_object = s3_client.get_object(Bucket=bucket_name, Key=sftp_textfile)
        objectkey_content = json_object['Body'].read(20)
        
        content = objectkey_content.decode("utf-8") 
        print(content)
        
        #get s3 bucket as dynamodb table name
        tablename = bucket_name
        #get etag from s3 event and use it as hash key
        index_etag = event['Records'][0]['s3']['object']['eTag']
        filename = sftp_textfile.rsplit( ".", 1 )[ 0 ]
        
        #write data to dynamodb     
        data = dynamo_client.put_item(
            TableName=tablename,
            Item={
                    'FileTag': {
                        'S':  index_etag
                    },
                    'FileName': {
                        'S':  filename
                    },
                    'FileContent': {
                        'S': content
                    },
            })
        #finally delete object after been processed 
        s3_client.delete_object(Bucket=bucket_name, Key=sftp_textfile)
    except:
        print("An exception occurred")