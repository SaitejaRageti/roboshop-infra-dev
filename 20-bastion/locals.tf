locals  {
    ami_id = data.aws_ami.joindevops.id

    common_tags = {
        Project = var.project
        environment = var.environment
    }

    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    public_subnet_id = split ("," , data.aws_ssm_parameter.public_subnet_id.value)[0]
}