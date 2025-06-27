resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = 

  tags = merge (
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-bastion"
    }

  )
}