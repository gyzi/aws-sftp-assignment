output "endpoint" {
  value = aws_transfer_server.sftp_server.endpoint
}

output "transfer_sftp_arn" {
  value = aws_transfer_server.sftp_server.arn
}

output "transfer_sftp_id" {
  value = aws_transfer_server.sftp_server.id
}