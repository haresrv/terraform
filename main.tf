terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  } # Using S3 to manage state file.
  backend "s3" { 
    bucket                  = "com.unique.bucket.name.haresrv"
    key                     = "path_to_state_file/terraform.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "~/.aws/credentials" # Download AWS CLI and execute aws configure to setup the credentials
  }
}
###

# EC2 with EBS setup using our custom module

###

module "test_instance" {
  source                 = "./modules/EC2"
  # Find AMI ID from console/marketplace. Note that AMI ID's are limited to region.
  ami_id                 = "ami-087c17d1fe0178315"
  instance_type          = "t3.micro"
  root_user_key_pair     = var.root_user_key_pair
  availability_zone      = var.default_availability_zone
  short_tag              = "HareSRV-node"
  vpc_security_group_ids = module.allow_ssh_security_group.security_group_ids
  ec2_instance_count     = 1
  ec2_ebs_volume_count   = 2
  ec2_ebs_volume_sizes   = [50, 100]
  ec2_device_names       = ["/dev/sdf", "/dev/sdg"]
}
###

# Security Group setups using our custom module

###

module "allow_ssh_security_group" {
  source              = "./modules/SG"
  vpc_id              = var.vpc_id
  sg_name_prefix      = "ec2-sg"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  tags = {
    Name = "created with terraform"
  }
  ingress_ports    = [22]
  ingress_protocol = "tcp"
  egress_protocol  = "all"
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.root_user_key_pair
  public_key = var.root_user_public_key
}

###

# IAM Role setups using our custom module

###

# IAM Role for EC2 Instance Profile
# Allows EC2 instances in an EMR cluster to access other AWS services such as S3.
module "iam_instance_profile_for_ec2" {
  source             = "./modules/IAM"
  iam_role_name      = "iam_instance_profile_for_ec2"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  policy             = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Resource": "*",
        "Action": [
            "cloudwatch:*",
            "ec2:Describe*",
            "elasticmapreduce:Describe*",
            "elasticmapreduce:ListBootstrapActions",
            "elasticmapreduce:ListClusters",
            "elasticmapreduce:ListInstanceGroups",
            "elasticmapreduce:ListInstances",
            "elasticmapreduce:ListSteps",
            "s3:*"
        ]
    }]
}
EOF
}

resource "aws_iam_instance_profile" "emr_profile" {
  name = "emr_profile"
  role = module.iam_instance_profile_for_ec2.role_arn
}