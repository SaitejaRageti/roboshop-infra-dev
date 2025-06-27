variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "frontend_sg_name" {
  default = "frontend_sg"
}

variable "sg_description" {
  default = "sg for frontend instance"
}

variable "bastion_sg_name" {
  default = "bastion_sg"
}

variable "bastion_description" {
  default = "sg for bastion instance"
}