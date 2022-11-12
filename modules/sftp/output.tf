output "endpoint" {
  value = aws_transfer_server.sftp_server.endpoint
}

output "transfer_sftp_arn" {
  value = aws_transfer_server.sftp_server.arn
}

output "transfer_sftp_id" {
  value = aws_transfer_server.sftp_server.id
}

output "lambda_function" {
  description = "lambda function name"
  value       = aws_lambda_function.lambda.function_name
}
output "dynamodb_table" {
  description = "dynamodb table name"
  value       = aws_dynamodb_table.sftp_data.name
}