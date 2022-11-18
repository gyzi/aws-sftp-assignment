# aws-sftp-ssignment
Assignment to create sftp server and extract and store content of textfiles in aws using terrraform


This terraform module will deploy the following services:

- [x] EC2 Instance
    - Access ssh/scp use directory as sftp
    - Iam to access s3 bucket
- [x] Lambda
    - Function
    - Iam s3 & dynamodb cloudwatch access
- [x] S3 Bucket
    - Bucket
- [x] DynamoDB Table
    - store content for textfiles

## Thoughts on the soluation ?
- Using SFTP EC2 and connect with serviceless service
    - Using EC2 as Sftp Server cost effective
    - Lambda and agile
    - S3 Bucket scalable, Durability many more
- Using Terraform 
    - easy to automate and maintain setup state 
    - principles Infrastructure as a Code 
- security/zero-trust
    - encryption at rest within bucket, table
    - encryption in transit between native aws service
    - sftp use public key encryption
    - least privilege deployment with IAM roles/policys
---
## Connecting to sftp
- Use ubuntu username and test private key shared in email
- To access via public ip as bellow 
'''' 
sftp -i PATH/test_id_rsa ubuntu@public_ip
'''
## Usage Instructions
- Add/Update inputs entries, 
- Then validate, plan and apply resources
```
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```
- To destroy note default bucket_on_destroy value is true
```
terraform destroy
```
- use pub/priv keys in misc folder to access sftp, note user is testuser
## Requirements
| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |
| random | >= 3.1.0 |

## Inputs/Variables
| Name | info |
|------|---------|
| bucket_name | name for s3 bucket used as sftp directory |
| private_key_path | location for private_key_path  |
| instance_ami | select ami id in specifed region - ubuntu 22.04 |
| instance_type | its set t2.micro freetier |
| key_pair_name | keypair name for accessing sftp |
| s3_access_key | s3_access_key for s32fs mount s3 to EC2 |
| s3_secret_key | s3_secret_key for s32fs mount s3 to EC2 |
| lambda_location | lambda function location zip file |

## Outputs

| Name | Description |
|------|-------------|
| lambda_function | lambda function name |
| dynamodb_table | dynamodb table name |
| public_ip | ip addr for ec2 ssftp to access s3 directory |

