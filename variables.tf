variable "region" {
  description = "AWS Deployment region.."
  default     = "us-east-1"
}

variable "root_user_key_pair" {
  description = "Name for key pair"
  default     = "default key pair to use."
}

variable "root_user_public_key" {
  sensitive = true
  # Generate using ssh rsa or Putty and use it. If we create keypair using Terraform, then private key will be exposed in state file.
  description = "SSH public key for root user"
}

variable "default_availability_zone" {
  description = "Availability zone to be used by default"
  default     = "us-east-1a"
}

variable "vpc_id" {
  description = "Id of VPC used by subnet"
}