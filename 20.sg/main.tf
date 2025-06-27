module "frontend" {
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = var.sg_description
    sg_tags = var.sg_tags
    sg_name = var.sg_name
    vpc_id = local.vpc_id
}