provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "man-server" {
    ami = var.ami_val
    instance_type = var.instance_type_value
    
}

