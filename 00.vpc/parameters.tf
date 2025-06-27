resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}-${var.environment}/vpc_id"
  type  = "String"
  value = module.aws_vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  value = join(",", module.aws_vpc.aws_public_subnet)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  value = join(",", module.aws_vpc.aws_private_subnet)
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  value = join(",", module.aws_vpc.aws_database_subnet)
}
