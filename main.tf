
module "sftp" {
  source = "./modules/sftp"

  sftp_servername    = var.sftp_servername
  bucket_name        = var.bucket_name
  sftp_users_ssh_key = var.sftp_users_ssh_key
  lambda_location    = "lambda/lambda_function.zip"

}