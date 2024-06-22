provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "man-instance" {
  instance_type = "t2.micro"
  ami = "ami-0c67b047b06ddd4cf"
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "man-bucket-demo-v1"
}

resource "aws_dynamodb_table" "terraform-lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}