<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.ebs_volume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_instance.ec2_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_volume_attachment.volume_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | Amazon Machine Image for particular EC2 instance | `any` | n/a | yes |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability zone to be used by default | `string` | `"us-east-1a"` | no |
| <a name="input_ec2_device_names"></a> [ec2\_device\_names](#input\_ec2\_device\_names) | Device name to be used by EBS volume attachments | `list(string)` | n/a | yes |
| <a name="input_ec2_ebs_volume_count"></a> [ec2\_ebs\_volume\_count](#input\_ec2\_ebs\_volume\_count) | Number of EBS volumes to be attached | `number` | n/a | yes |
| <a name="input_ec2_ebs_volume_sizes"></a> [ec2\_ebs\_volume\_sizes](#input\_ec2\_ebs\_volume\_sizes) | Size of EBS volumes to be attached in GiB | `list(number)` | n/a | yes |
| <a name="input_ec2_instance_count"></a> [ec2\_instance\_count](#input\_ec2\_instance\_count) | Number of replicas of EC2 instances | `number` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Deployment region.. | `string` | `"us-east-1"` | no |
| <a name="input_root_user_key_pair"></a> [root\_user\_key\_pair](#input\_root\_user\_key\_pair) | Name for key pair | `any` | n/a | yes |
| <a name="input_short_tag"></a> [short\_tag](#input\_short\_tag) | Optional tags for EC2 instance | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | Security Group to be attached to instance | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
<!-- END_TF_DOCS -->