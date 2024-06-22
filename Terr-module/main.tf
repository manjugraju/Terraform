provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
    source = "./module_ec2"
    ami_val = "ami-0c67b047b06ddd4cf"
    instance_type_value = "t2.micro"
}

output "public_ip_address" {
    value = module.ec2_instance.public_ip_address
}

