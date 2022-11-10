import json
import boto3

s3_client = boto3.client("s3")
S3_BUCKET = bucket = event['Records'][0]['s3']['bucket']['name']
s3_file_name =  event['Records'][0]['s3']['object']['key']
json_object =   s3_client.get_object(Bucket=bucket_name, Key= s3_file_name)
jsonFileReader  =   json_object['Body'].read()
print(jsonFileReader)

def lambda_handler(event, context):
    response = s3_client.list_objects_v2(
        Bucket=S3_BUCKET,,,)
    s3_files = response["Contents"]
    for s3_file in s3_files:
        file_content = json.loads(s3_client.get_object(
            Bucket=S3_BUCKET, Key=s3_file["Key"])["Body"].read())
        print(file_content)

import boto3

s3_client = boto3.client("s3")
S3_BUCKET = 'BUCKET_NAME'

def lambda_handler(event, context):
  object_key = "OBJECT_KEY"  # replace object key
  file_content = s3_client.get_object(
      Bucket=S3_BUCKET, Key=object_key)["Body"].read()
  print(file_content)

# import json
# import urllib.parse
# import boto3

# print('Loading function')

# s3 = boto3.client('s3')


# def lambda_handler(event, context):
#     #print("Received event: " + json.dumps(event, indent=2))

#     # Get the object from the event and show its content type
#     bucket = event['Records'][0]['s3']['bucket']['name']
#     key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
#     try:
#         response = s3.get_object(Bucket=bucket, Key=key)
#         print("CONTENT TYPE: " + response['ContentType'])
#         return response['ContentType']
#     except Exception as e:
#         print(e)
#         print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
#         raise e
