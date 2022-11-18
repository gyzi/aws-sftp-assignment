# Lambda Role to intract with s3 API 
resource "aws_iam_role" "lambda_s3_role" {
  name               = "${var.bucket_name}-lambda-s3-role"
  assume_role_policy = local.lambda_assume_role
}
# Lambda Policy to intract with cloudwatch API 
resource "aws_iam_role_policy" "lambda_s3_policy" {
  name   = "${var.bucket_name}-lambda-s3-policy"
  role   = aws_iam_role.lambda_s3_role.id
  policy = local.s3_policy
}
# Lambda Policy to intract with s3 API
resource "aws_iam_role_policy" "lambda_logging_policy" {
  name   = "${var.bucket_name}-lambda-logging-policy"
  role   = aws_iam_role.lambda_s3_role.id
  policy = local.cloudwatch_policy
}
# Lambda Policy to intract with DynamoDB API
resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name   = "${var.bucket_name}-lambda-dynamodb-policy"
  role   = aws_iam_role.lambda_s3_role.id
  policy = local.dynamodb_policy
}


# EC2 IAM role for sftp server
resource "aws_iam_role" "ec2_iam_role" {
  name               = "ec2_iam_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name  = "ec2_instance_profile"
  role = aws_iam_role.ec2_iam_role.id
}

resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  name   = "ec2_iam_role_policy"
  role   = aws_iam_role.ec2_iam_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::${var.bucket_name}"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::${var.bucket_name}/*"]
    }
  ]
}
EOF
}