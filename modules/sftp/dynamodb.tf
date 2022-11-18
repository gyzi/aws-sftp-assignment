resource "aws_dynamodb_table" "sftp_data" {
  name           = "${var.bucket_name}"
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

  depends_on = [aws_s3_bucket.sftp_bucket]

}



