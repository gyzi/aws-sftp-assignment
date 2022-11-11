
# S3 Bucket with SSE-S3 Encryption
resource "aws_s3_bucket" "sftp_bucket" {
  bucket = var.bucket_name
  force_destroy = var.bucket_on_destroy
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.sftp_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Transfer SFTP server using Manged identiy with public key access
resource "aws_transfer_server" "sftp_server" {
  tags = {
    Name = var.sftp_servername
  }
  security_policy_name            = "TransferSecurityPolicy-2020-06"
  endpoint_type                   = "PUBLIC"
  protocols                       = ["SFTP"]
  identity_provider_type          = "SERVICE_MANAGED"
  pre_authentication_login_banner = "Warning accessing sftp.."
  force_destroy                   = false
  logging_role                    = aws_iam_role.transfer_logging_s3.arn
  # Worflow to trigger lambda on upload
  workflow_details {
    on_upload {
      execution_role = aws_iam_role.transfer_lambda_role.arn
      workflow_id    = aws_transfer_workflow.workflow.id
    }
  }
}
# trigger lambda when file upload
resource "aws_transfer_workflow" "workflow" {
  steps {
    custom_step_details {
      name                 = "lambda"
      source_file_location = "$${original.file}"
      target               = aws_lambda_function.lambda.arn
      timeout_seconds      = 60
    }
    type = "CUSTOM"
  }
}

# Add Users and directory access to s3 Buckett
resource "aws_transfer_user" "this" {
  for_each       = var.sftp_users
  server_id      = aws_transfer_server.sftp_server.id
  user_name      = each.key
  role           = aws_iam_role.user.arn
  home_directory = "/${aws_s3_bucket.sftp_bucket.id}/"
  depends_on     = [aws_s3_bucket.sftp_bucket]
}

# Add user public keys
resource "aws_transfer_ssh_key" "this" {
  for_each   = var.sftp_users_ssh_key
  server_id  = aws_transfer_server.sftp_server.id
  user_name  = each.key
  body       = each.value
  depends_on = [aws_transfer_user.this]
}






