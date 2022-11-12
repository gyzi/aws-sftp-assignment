# aws-sftp-ssignment
Assignment to create sftp server and text file manipulation  in aws using terrraform 

[[_TOC_]]

This terraform module will deploy the following services:

- [x] Transfer "SFTP" family
    - sftp with s3 directory
    - workflow - lambda 
    - Iam to assume lambda
    - Iam to assume s3 bucket
- [x] Lambda
    - Function
    - Iam s3 & dynamodb cloudwatch access
- [x] S3 Bucket
    - Bucket
- [x] DynamoDB Table
    - store content for textfiles

## Thoughts on the soluation ?
- Using aws serviceless service
    - AWS transfer AWS native sftp service, integrate well with s3/lambda/dynamodb
    - Lambda cost effective and agile
    - S3 Bucket scalable, Durability many features
- Using Terraform 
    - easy to automate and maintain setup state 
    - principles Infrastructure as a Code 
- security/zero-trust
    - encryption at rest within bucket, table
    - encryption in transit between native aws service
    - sftp use public key encryption
    - least privilege deployment with IAM roles/policys
- flow overview 
---
![Alt overview](lambda/flow-overview.png)
---


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
| sftp_servername | name sftp server used as prefix for creating resources |
| sftp_users_ssh_key | user:key defines users with their public keys for access |
| lambda_location | lambda function location zip file |

## Outputs

| Name | Description |
|------|-------------|
| lambda_function | lambda function name |
| dynamodb_table | dynamodb table name |
| sftp_endpoint | Endpoint to connect sftp transfer server |

