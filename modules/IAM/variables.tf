variable "iam_role_name" {
  description = "Custom role name to refer to the created role"
}

variable "assume_role_policy" {
  description = "Policy that grants an entity permission to assume the role."
}

variable "policy" {
  description = "Policy to be attached"
}