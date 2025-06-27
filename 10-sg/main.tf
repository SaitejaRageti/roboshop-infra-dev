module "frontend" {
    # source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/SaitejaRageti/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    frontend_sg_name = var.frontend_sg_name
    environment = var.environment
    sg_description = var.sg_description
    vpc_id = local.vpc_id

}