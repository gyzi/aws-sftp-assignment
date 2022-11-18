
variable "bucket_name" {
  type        = string
  description = "s3 bucket name"
}
variable "region" {
  type        = string
  description = "region"
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

variable "key_pair_name" {
  type        = string
  description = "key_pair_name"
}

variable "instance_type" {
  type        = string
  description = "instance_type"
}

variable "instance_ami" {
  type        = string
  description = "instance_ami"
}

variable "s3_access_key" {
  type        = string
  description = "s3_access_key"
}

variable "s3_secret_key" {
  type        = string
  description = "s3_secret_key"
}

variable "public_key_path" {
  type        = string
  description = "public_key_path"
}

variable "private_key_path" {
  type        = string
  description = "private_key_path"
}