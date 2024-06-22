provider "aws" {
    region = "us-east-1"
}

variable "ami" {
    description = "ami value "
}

variable "instance_type" {
    description = "This is instance type"
  
}

resource "aws_instance" "man-appserver" {
    ami =var.ami
    instance_type = var.instance_type
}