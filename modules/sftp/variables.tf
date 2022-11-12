
variable "bucket_name" {
  type        = string
  description = "s3 bucket name"
}
variable "bucket_on_destroy" {
  type        = string
  default     = true
  description = "s3 bucket name"
}
variable "lambda_location" {
  type        = string
  description = "lambda zip file location"
}

variable "sftp_servername" {
  type        = string
  description = "sftp server name"
}

variable "sftp_users_ssh_key" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Map of users with key as username and value as their public SSH key
    ```{
      user = ssh_public_key_content
    }```
  EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of key value pair to assign to resources"
}
