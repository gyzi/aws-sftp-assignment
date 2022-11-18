
resource "aws_security_group" "sftp_sg" {
name = "${var.bucket_name}"
ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
# EC2 server for sftp 
resource "aws_instance" "server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  security_groups             = ["${var.bucket_name}"]
  key_name                    = var.key_pair_name
  #iam_instance_profile = aws_iam_instance_profile.instance_profile.id
  root_block_device {
    volume_size = 15
  }  
  user_data            = <<EOF
#!/bin/bash
  sudo apt-get update
  sudo apt-get install automake autotools-dev fuse g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config -y
  cd /tmp/
  git clone https://github.com/s3fs-fuse/s3fs-fuse.git
  cd s3fs-fuse
  ./autogen.sh
  ./configure --prefix=/usr --with-openssl
  make
  sudo make install
  which s3fs
  sudo echo "${var.s3_access_key}:${var.s3_secret_key}" > /etc/passwd-s3fs
  sudo chmod 640 /etc/passwd-s3fs
  mkdir "/home/ubuntu/${var.bucket_name}"
  chown ubuntu:ubuntu  "/home/ubuntu/${var.bucket_name}"

  s3fs "${var.bucket_name}" -o use_cache=/tmp -o allow_other -o uid=1000 -o mp_umask=002 -o multireq_max=5 "/home/ubuntu/${var.bucket_name}"

EOF

}
#Allocate eip to server
resource "aws_eip" "server" {
  vpc       = true
  instance  = aws_instance.server.id
}

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


