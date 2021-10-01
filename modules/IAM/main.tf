resource "aws_iam_role" "iam_service_role" {
  name               = var.iam_role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy" "iam_emr_service_policy" {
  name   = "iam_emr_service_policy"
  role   = aws_iam_role.iam_service_role.id
  policy = var.policy
}