# Configure the S3 backend for storing Terraform state
terraform {
  backend "s3" {
    bucket = "week21-s3-larryjohnson"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}