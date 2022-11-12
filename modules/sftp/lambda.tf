
# Lambda function to process text files
resource "aws_lambda_function" "lambda" {
  filename         = var.lambda_location
  source_code_hash = filebase64sha256("lambda/lambda_function.zip")
  role             = aws_iam_role.lambda_s3_role.arn
  function_name    = "${var.sftp_servername}-function"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 60
}

# Lambda Role to intract with s3 API 
resource "aws_iam_role" "lambda_s3_role" {
  name               = "${var.sftp_servername}-lambda-s3-role"
  assume_role_policy = local.lambda_assume_role
}
# Lambda Policy to intract with cloudwatch API 
resource "aws_iam_role_policy" "lambda_s3_policy" {
  name   = "${var.sftp_servername}-lambda-s3-policy"
  role   = aws_iam_role.lambda_s3_role.id
  policy = local.s3_policy
}
# Lambda Policy to intract with s3 API
resource "aws_iam_role_policy" "lambda_logging_policy" {
  name   = "${var.sftp_servername}-lambda-logging-policy"
  role   = aws_iam_role.lambda_s3_role.id
  policy = local.cloudwatch_policy
}
# Lambda Policy to intract with DynamoDB API
resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name   = "${var.sftp_servername}-lambda-dynamodb-policy"
  role   = aws_iam_role.lambda_s3_role.id
  policy = local.dynamodb_policy
}


# Transer Role to interact with lambda API
resource "aws_iam_role" "transfer_lambda_role" {
  name = "${var.sftp_servername}-transfer-lambda-role"

  assume_role_policy = local.transfer_assume_role
}

# Transer Policy to interact with lambda
resource "aws_iam_role_policy" "transfer_lambda_policy" {
  name = "${var.sftp_servername}-transfer-lambda-policy"
  role = aws_iam_role.transfer_lambda_role.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowInvokeLambda",
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "${aws_lambda_function.lambda.arn}"
        }
    ]
}
POLICY
}