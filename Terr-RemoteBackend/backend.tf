terraform {
  backend "s3" {
    bucket = "man-bucket-demo-v1"
    key    = "man/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}