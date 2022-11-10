
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
}


resource "aws_transfer_server" "example" {
  tags = {
    Name = var.sftp_servername
  }
  security_policy_name            = "TransferSecurityPolicy-2020-06"
  endpoint_type                   = "PUBLIC"
  protocols                       = ["SFTP"]
  identity_provider_type          = "SERVICE_MANAGED"
  pre_authentication_login_banner = "Warning accessing sftp.."
  force_destroy                   = false
  logging_role                    = aws_iam_role.logging.arn

  workflow_details {
    on_upload {
      execution_role = aws_iam_role.transfer.arn
      workflow_id    = aws_transfer_workflow.example.id
    }
  }
}

resource "aws_transfer_workflow" "example" {
  steps {
    custom_step_details {
      name                 = "example"
      source_file_location = "$${original.file}"
      target               = aws_lambda_function.example.arn
      timeout_seconds      = 60
    }
    type = "CUSTOM"
  }
}

resource "aws_transfer_ssh_key" "example" {
  server_id  = aws_transfer_server.example.id
  user_name  = aws_transfer_user.example.user_name
  depends_on = [aws_transfer_server.example]
  body       = var.ssh_pub_key
}

resource "aws_transfer_user" "example" {
  server_id      = aws_transfer_server.example.id
  user_name      = var.sftp_username
  role           = aws_iam_role.s3.arn
  home_directory = "/${aws_s3_bucket.example.id}/"
  depends_on     = [aws_s3_bucket.example]
}




