provider "aws" {
    region = "us-east-1"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "webvpc" {
    cidr_block= var.cidr
}

resource "aws_key_pair" "webserver-keypair"{
    key_name =  "terraform-demo-man"
    public_key = file("C:\\Users\\Shruthi/.ssh/id_rsa.pub")
}

resource "aws_subnet" "web-subnet" {
    vpc_id = aws_vpc.webvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "web-gw" {
    vpc_id =  aws_vpc.webvpc.id  
}

resource "aws_route_table" "web-rt" {
    vpc_id = aws_vpc.webvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.web-gw.id
    }
}

resource "aws_route_table_association" "web-rta" {
    subnet_id = aws_subnet.web-subnet.id
    route_table_id = aws_route_table.web-rt.id
}

resource "aws_security_group" "web-sg" {
    name = "web-sg"
    vpc_id = aws_vpc.webvpc.id
    ingress {
        description = "enable HTTP"
        from_port = 80
        to_port = 80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      ingress {
        description = "enable ssh"
        from_port = 22
        to_port = 22 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0 
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "enable http and ssh access"
    }  
}

resource "aws_instance" "man-web-server" {
    ami = "ami-0c67b047b06ddd4cf" 
    instance_type = "t2.micro"
    key_name = aws_key_pair.webserver-keypair.key_name
    vpc_security_group_ids = [ aws_security_group.web-sg.id ]
    subnet_id = aws_subnet.web-subnet.id

    connection {
      type = "ssh"
      user =  "ec2-user"
      private_key = file("C:\\Users\\Shruthi/.ssh/id_rsa")
      host = self.public_ip
    }
    provisioner "file" {
        source = "C:\\Users\\Shruthi\\Terraform_practice\\Terr-webappdeploy\\index.html"
        destination = "/temp/index.html"
      
    }

    provisioner "remote-exec" {
        inline = [ 
            "sudo mv  /temp/index.html /var/www/html/index.html",
            "sudo chmod 644 /var/www/html/index.html",
            "echo 'hello from man web server'",
            "sudo yum install httpd -y",
            "sudo systemctl enable httpd",
            "sudo systemctl start httpd",
         ]
      
    }

}



