
locals {
  private_key_path = "./misc/test_id_rsa"
  ssh_user         = "ubuntu"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.key_pair_name
  public_key = file("./misc/test_id_rsa.pub")
}

module "sftp" {
  source             = "./modules/sftp"
  private_key_path   = local.private_key_path
  instance_ami       = var.instance_ami
  instance_type      = var.instance_type
  key_pair_name      = var.key_pair_name
  bucket_name        = var.bucket_name
  lambda_location    = var.lambda_location
  s3_access_key      = var.s3_access_key
  s3_secret_key      = var.s3_secret_key

}
