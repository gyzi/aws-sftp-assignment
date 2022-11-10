
resource "aws_lambda_function" "example" {
  filename         = "lambda/lambda_function.zip"
  source_code_hash = filebase64sha256("lambda/lambda_function.zip")
  role             = aws_iam_role.lambda.arn
  function_name    = "test-lambda"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 60
}

resource "aws_iam_role" "lambda" {
  name               = "tf-lambda-s3-role"
  assume_role_policy = <<EOF
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
}

resource "aws_iam_role_policy" "lambda" {
  name   = "tf-lambda-s3-policy"
  role   = aws_iam_role.lambda.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAccessLambda",
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:CreateLogGroup",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}


resource "aws_iam_role" "transfer" {
  name = "tf-transfer-lambda-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "transfer.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "transfer" {
  name = "tf-test-transfer-user-iam-policy"
  role = aws_iam_role.transfer.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowFullAccesstoS3",
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "${aws_lambda_function.example.arn}"
        }
    ]
}
POLICY
}