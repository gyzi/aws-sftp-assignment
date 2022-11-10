
variable "bucket_name" {
  type        = string
  description = "s3 bucket name"
}

variable "sftp_servername" {
  type        = string
  description = "sftp server name"
}

variable "ssh_pub_key" {
  type        = string
  description = "ssh public key"
}

variable "sftp_username" {
  type        = string
  description = "sftp username"
}

