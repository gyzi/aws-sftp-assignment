locals {

  #Allow Put to s3 only textfiles
  private_key_path = var.private_key_path
  
  s3_policy  = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowListing",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.sftp_bucket.arn}"
      ]
    },
    {
      "Sid": "ListObjectAccess",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:DeleteObjectVersion",
        "s3:DeleteObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "${aws_s3_bucket.sftp_bucket.arn}/*"
    },
    {
      "Sid": "AllowPutTextFileOnly",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject"
      ],
      "Resource": "${aws_s3_bucket.sftp_bucket.arn}/*.txt"
    }
  ]
}
POLICY

  cloudwatch_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowLogging",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:CreateLogGroup",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:log-group:/aws/transfer/*"
        }
    ]
}
POLICY

    lambda_assume_role = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

    dynamodb_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ReadWriteTable",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGetItem",
                "dynamodb:GetItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWriteItem",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "logs:CreateLogGroup"
            ],
            "Resource": "${aws_dynamodb_table.sftp_data.arn}"
        }
    ]
} 
EOF


}