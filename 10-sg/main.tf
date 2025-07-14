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

module "mongodb" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = var.mongodb_sg_name
    environment = var.environment
    sg_description = var.mongodb_description
    vpc_id = local.vpc_id
}

module "redis" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = "redis"
    environment = var.environment
    sg_description = "security group for redis"
    vpc_id = local.vpc_id
}

module "rabbitmq" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = "rabbitmq"
    environment = var.environment
    sg_description = "security group for rabbitmq"
    vpc_id = local.vpc_id
}

module "mysql" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = "mysql"
    environment = var.environment
    sg_description = "security group for mysql"
    vpc_id = local.vpc_id
}

module "catalogue" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    sg_name = "catalogue"
    environment = var.environment
    sg_description = "sg for catalogue"
    vpc_id = local.vpc_id
}

##catalogue accepting connections from vpn bastion and backend alb
resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}
resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.catalogue.sg_id
}


##mysql accepting connections from vpn
resource "aws_security_group_rule" "mysql_vpn" {
  count = length(var.mysql_ports_vpn)
  type              = "ingress"
  from_port         = var.mysql_ports_vpn[count.index]
  to_port           = var.mysql_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mysql.sg_id
}

##redis accepting connections from VPN
resource "aws_security_group_rule" "redis_vpn" {
  count = length(var.redis_ports_vpn)
  type              = "ingress"
  from_port         = var.redis_ports_vpn[count.index]
  to_port           = var.redis_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.redis.sg_id
}

##rabbitmq accepting connections from VPN
resource "aws_security_group_rule" "rabbitmq_vpn" {
  count = length(var.rabbitmq_ports_vpn)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_vpn[count.index]
  to_port           = var.rabbitmq_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.rabbitmq.sg_id
}

##mongodb accepting connections from vpn
resource "aws_security_group_rule" "mongodb_vpn" {
  count = length(var.mongodb_ports_vpn)
  type              = "ingress"
  from_port         = var.mongodb_ports_vpn[count.index]
  to_port           = var.mongodb_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mongodb.sg_id
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


##Backend ALB
resource "aws_security_group_rule" "backend_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}

