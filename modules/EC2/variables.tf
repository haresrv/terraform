variable "region" {
  description = "AWS Deployment region.."
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Machine Image for particular EC2 instance"
}

variable "instance_type" {
  description = "Type of instance"
}

variable "root_user_key_pair" {
  description = "Name for key pair"
}

variable "short_tag" {
  description = "Optional tags for EC2 instance"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security Group to be attached to instance"
  type        = set(string)
}


variable "ec2_ebs_volume_count" {
  description = "Number of EBS volumes to be attached"
  type        = number
}

variable "ec2_ebs_volume_sizes" {
  description = "Size of EBS volumes to be attached in GiB"
  type        = list(number)
}

variable "ec2_device_names" {
  description = "Device name to be used by EBS volume attachments"
  type        = list(string)
}

variable "ec2_instance_count" {
  description = "Number of replicas of EC2 instances"
  type        = number
}

variable "availability_zone" {
  description = "Availability zone to be used by default"
  default     = "us-east-1a"
}