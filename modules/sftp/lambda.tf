
# Lambda function to process text files
resource "aws_lambda_function" "lambda" {
  filename         = var.lambda_location
  source_code_hash = filebase64sha256("lambda/lambda_function.zip")
  role             = aws_iam_role.lambda_s3_role.arn
  function_name    = "${var.bucket_name}-function"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 60
}

# Adding S3 bucket as trigger to lambda and giving the permissions
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.sftp_bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "ambda_permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.sftp_bucket.id}"
}


