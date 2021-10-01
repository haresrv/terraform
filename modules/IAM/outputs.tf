# ARN for generated role
output "role_arn" {
  value = aws_iam_role.iam_service_role.arn
}    