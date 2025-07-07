variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "sg_tags" {
  default = {
  }
}

variable "sg_description" {
  default = "created sg group for frontend instance"
}

variable "sg_name" {
  default = "frontend-sg-group"
}