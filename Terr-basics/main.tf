variable "region" {
    description = "region variable"
    type = string
    default = "us-east-1"
}

variable "ami" {
    description = "ec2 image AMI"
    type = string
    default = "ami-0c67b047b06ddd4cf"
}

variable "instance_type" {
    description = "instance type"
    type = string
    default = "t2.micro"
}

# create an EC2 instance 
provider "aws" {
   region = var.region
}

resource "aws_instance" "man-webserver5" {
    ami = var.ami
    instance_type = var.instance_type
}

output "dnsname" {
  
  value = aws_instance.man-webserver5.public_dns
}
