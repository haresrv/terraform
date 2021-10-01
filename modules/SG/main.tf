locals {
  num_rules_ingress_sg   = length(var.ingress_ports) * length(var.ingress_security_groups)
  num_rules_ingress_cidr = length(var.ingress_ports) * length(var.ingress_cidr_blocks)
  num_rules_egress_sg    = length(var.egress_security_groups)
  num_rules_egress_cidr  = length(var.egress_cidr_blocks)

  rules_ingress_cidr = flatten([
    for port in var.ingress_ports : [
      for cidr in var.ingress_cidr_blocks : {
        port = port
        cidr = cidr
      }
    ]
  ])

  rules_ingress_sg = flatten([
    for port in var.ingress_ports : [
      for sg in var.ingress_security_groups : {
        port = port
        sg   = sg
      }
    ]
  ])

  num_security_groups_ingress_sg   = ceil(local.num_rules_ingress_sg / var.maximum_rules_per_sg)
  num_security_groups_ingress_cidr = ceil(local.num_rules_ingress_cidr / var.maximum_rules_per_sg)
  num_security_groups_egress_sg    = ceil(local.num_rules_egress_sg / var.maximum_rules_per_sg)
  num_security_groups_egress_cidr  = ceil(local.num_rules_egress_cidr / var.maximum_rules_per_sg)
}

// count = 0 --> then resource won't be created.
// Ingress security groups
resource "aws_security_group" "security-groups-ingress-cidr" {
  count       = local.num_security_groups_ingress_cidr
  name        = format("%s-ingress-cidr-%s", var.sg_name_prefix, count.index)
  description = "Ingress security group with new CIDR restriction"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group" "security-groups-ingress-sg" {
  count       = local.num_security_groups_ingress_sg
  name        = format("%s-ingress-sg-%s", var.sg_name_prefix, count.index)
  description = "Ingress security group using existing security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

// Egress security groups
resource "aws_security_group" "security-groups-egress-cidr" {
  count       = local.num_security_groups_egress_cidr
  name        = format("%s-egress-cidr-%s", var.sg_name_prefix, count.index)
  description = "Egress security group with new CIDR restriction"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group" "security-groups-egress-sg" {
  count       = local.num_security_groups_egress_sg
  name        = format("%s-egress-sg-%s", var.sg_name_prefix, count.index)
  description = "Egress security group using existing security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

// Ingress Rules
resource "aws_security_group_rule" "ingress_cidr_rules" {
  count             = local.num_rules_ingress_cidr
  description       = format("Ingress CIDR rule %s for port %s", count.index, local.rules_ingress_cidr[count.index]["port"])
  security_group_id = aws_security_group.security-groups-ingress-cidr[(count.index % length(aws_security_group.security-groups-ingress-cidr))].id
  type              = "ingress"
  from_port         = local.rules_ingress_cidr[count.index]["port"]
  to_port           = local.rules_ingress_cidr[count.index]["port"]
  protocol          = var.ingress_protocol
  cidr_blocks       = [local.rules_ingress_cidr[count.index]["cidr"]]
}

resource "aws_security_group_rule" "ingress_sg_rules" {
  count                    = local.num_rules_ingress_sg
  description              = format("Ingress SG rule %s for port %s", count.index, local.rules_ingress_sg[count.index]["port"])
  security_group_id        = aws_security_group.security-groups-ingress-sg[(count.index % length(aws_security_group.security-groups-ingress-sg))].id
  type                     = "ingress"
  from_port                = local.rules_ingress_sg[count.index]["port"]
  to_port                  = local.rules_ingress_sg[count.index]["port"]
  protocol                 = var.ingress_protocol
  source_security_group_id = local.rules_ingress_sg[count.index]["sg"]
}

// Egress Rules
resource "aws_security_group_rule" "egress_cidr_rules" {
  count             = local.num_rules_egress_cidr
  description       = format("Egress CIDR rule %s", count.index)
  security_group_id = aws_security_group.security-groups-egress-cidr[(count.index % length(aws_security_group.security-groups-egress-cidr))].id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = var.egress_protocol
  cidr_blocks       = [var.egress_cidr_blocks[count.index]]
}

resource "aws_security_group_rule" "egress_sg_rules" {
  count                    = local.num_rules_egress_sg
  description              = format("Egress SG rule %s", count.index)
  security_group_id        = aws_security_group.security-groups-egress-sg[(count.index % length(aws_security_group.security-groups-egress-sg))].id
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = var.egress_protocol
  source_security_group_id = var.egress_security_groups[count.index]
}