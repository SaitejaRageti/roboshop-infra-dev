module "frontend" {
    # source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = var.frontend_sg_name
    environment = var.environment
    sg_description = var.sg_description
    vpc_id = local.vpc_id
}

module "bastion" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = var.bastion_sg_name
    environment = var.environment
    sg_description = var.bastion_description
    vpc_id = local.vpc_id
}

module "backend_alb" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = var.backend_alb_sg_name
    environment = var.environment
    sg_description = var.backend_alb_description
    vpc_id = local.vpc_id
}

module "vpn" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = var.vpn_sg_name
    environment = var.environment
    sg_description = var.vpn_description
    vpc_id = local.vpc_id
}

# bastion accepting connections from my laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# backend ALB accepting connections from my bastion host on port no 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}

#allowing connections from all to VPN --VPN ports 22, 443, 1194, 943

# resource "aws_security_group_rule" "main" {
#   count = length(var.vpn_ports)
#   type              = "ingress"
#   from_port         = var.vpn_ports[count.index]
#   to_port           = var.vpn_ports[count.index]
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = module.vpn.sg_id
# }

resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}


