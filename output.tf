output "public_ip" {
  value = module.sftp.public_ip
}
output "lambda_function" {
  description = "lambda function name"
  value       = module.sftp.lambda_function
}
output "dynamodb_table" {
  description = "dynamodb table name"
  value       = module.sftp.dynamodb_table
}
