# terraform
Terraform Playground

- Repository to host AWS based Terraform modules..

The modules provides additional customizations with 

1. EC2 with EBS
2. Security Groups 
3. IAM

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_allow_ssh_security_group"></a> [allow\_ssh\_security\_group](#module\_allow\_ssh\_security\_group) | ./modules/SG | n/a |
| <a name="module_iam_instance_profile_for_ec2"></a> [iam\_instance\_profile\_for\_ec2](#module\_iam\_instance\_profile\_for\_ec2) | ./modules/IAM | n/a |
| <a name="module_test_instance"></a> [test\_instance](#module\_test\_instance) | ./modules/EC2 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.emr_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_key_pair.ec2_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_availability_zone"></a> [default\_availability\_zone](#input\_default\_availability\_zone) | Availability zone to be used by default | `string` | `"us-east-1a"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Deployment region.. | `string` | `"us-east-1"` | no |
| <a name="input_root_user_key_pair"></a> [root\_user\_key\_pair](#input\_root\_user\_key\_pair) | Name for key pair | `string` | `"default key pair to use."` | no |
| <a name="input_root_user_public_key"></a> [root\_user\_public\_key](#input\_root\_user\_public\_key) | SSH public key for root user | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Id of VPC used by subnet | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->