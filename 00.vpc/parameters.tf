resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}-${var.environment}/vpc_id"
  type  = "String"
  value = module.aws_vpc.vpc_id
}