
# Iam role for Transfer to assume logging and s3 policy
resource "aws_iam_role" "transfer_logging_s3" {
  name = "${var.sftp_servername}-transfer-logging"

  assume_role_policy = local.transfer_assume_role
}
# Iam policy for Transfer for cloudwatch logging 
resource "aws_iam_role_policy" "transfer_logging" {
  name = "${var.sftp_servername}-transfer-logging"
  role = aws_iam_role.transfer_logging_s3.id
  policy = local.cloudwatch_policy
}
# Iam policy for Transfer for s3 API
resource "aws_iam_role_policy" "transfer_s3" {
  name   = "${var.sftp_servername}-transfer-s3"
  role   = aws_iam_role.transfer_logging_s3.id
  policy = local.s3_policy
}

# Directory role access for sftp user to interact with s3 
resource "aws_iam_role" "user" {
  name               = "${var.sftp_servername}-user-transfer-role"
  assume_role_policy = local.transfer_assume_role
}

resource "aws_iam_role_policy" "user" {
  name   = "${var.sftp_servername}-user-transfer-policy"
  role   = aws_iam_role.user.id
  policy = local.s3_policy
}
