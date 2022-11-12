resource "aws_dynamodb_table" "sftp_data" {
  name           = "${aws_transfer_server.sftp_server.id}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "FileTag"
  range_key      = "FileName"
  
  server_side_encryption {
   enabled = true 
  }
  
  attribute {
    name = "FileTag"
    type = "S"
  }

  attribute {
    name = "FileName"
    type = "S"
  }

  tags = {
    project    = var.sftp_servername
  }

  depends_on = [aws_transfer_server.sftp_server]
}



