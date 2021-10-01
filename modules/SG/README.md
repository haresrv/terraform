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
| [aws_security_group.security-groups-egress-cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.security-groups-egress-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.security-groups-ingress-cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.security-groups-ingress-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_cidr_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_sg_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_sg_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | CIDR blocks to attach to security groups for egress | `list(string)` | `[]` | no |
| <a name="input_egress_protocol"></a> [egress\_protocol](#input\_egress\_protocol) | Protocol to be used by egress rule | `any` | n/a | yes |
| <a name="input_egress_security_groups"></a> [egress\_security\_groups](#input\_egress\_security\_groups) | Existing security groups to attach to new security groups for egress | `list(string)` | `[]` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | CIDR blocks to attach to security groups for ingress | `list(string)` | `[]` | no |
| <a name="input_ingress_ports"></a> [ingress\_ports](#input\_ingress\_ports) | Ports to create ingress traffic rules for | `list(number)` | n/a | yes |
| <a name="input_ingress_protocol"></a> [ingress\_protocol](#input\_ingress\_protocol) | Protocol to be used by ingress rule | `any` | n/a | yes |
| <a name="input_ingress_security_groups"></a> [ingress\_security\_groups](#input\_ingress\_security\_groups) | Existing security groups to attach to new security groups for ingress | `list(string)` | `[]` | no |
| <a name="input_maximum_rules_per_sg"></a> [maximum\_rules\_per\_sg](#input\_maximum\_rules\_per\_sg) | Maximum number of rules for each security group | `number` | `50` | no |
| <a name="input_sg_name_prefix"></a> [sg\_name\_prefix](#input\_sg\_name\_prefix) | Prefix for security group names | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be attached to the resources created | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which to attach the security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_egress_security_group_ids"></a> [egress\_security\_group\_ids](#output\_egress\_security\_group\_ids) | IDs of the security groups that control egress to the resource |
| <a name="output_ingress_security_group_ids"></a> [ingress\_security\_group\_ids](#output\_ingress\_security\_group\_ids) | IDs of the security groups that control ingress to the resource |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | IDs of the security groups created by this module |
| <a name="output_security_groups"></a> [security\_groups](#output\_security\_groups) | Security groups created by this module |
<!-- END_TF_DOCS -->