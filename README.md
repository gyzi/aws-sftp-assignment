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
    - Iam s3 & cloudwatch access
- [x] S3 Bucket
    - Bucket
    - Role Policy

## Thoughts on the soluatio ?
- Using aws serviceless service
    - 
- Using Terraform 
- flow overview 


# Usage Instructions
## Example
```terraform
module "sftp" {
  source = "github.com/gyzi/aws-sftp-ssignment.git"
}
```

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
| sftp_servername | sftp server name |
| ssh_pub_key | ssh public key |
| sftp_username | sftp username |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of transfer server |
| id | ID of transfer server |
| endpoint | Endpoint of transfer server |

