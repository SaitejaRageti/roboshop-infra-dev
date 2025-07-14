locals  {
    ami_id = data.aws_ami.joindevops.id

    common_tags = {
        Project = var.project
        environment = var.environment
    }

    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
    rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
    
    private_subnet_id= split ("," , data.aws_ssm_parameter.private_subnet_id.value)[0]
}