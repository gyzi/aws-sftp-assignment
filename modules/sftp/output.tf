
output "lambda_function" {
  description = "lambda function name"
  value       = aws_lambda_function.lambda.function_name
}
output "dynamodb_table" {
  description = "dynamodb table name"
  value       = aws_dynamodb_table.sftp_data.name
}

output "public_ip" {
  description = "description"
  value       = aws_eip.server.public_ip
}
