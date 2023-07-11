terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.7.0"
    }
  }
}

#Specify AWS Region
provider "aws" {
  region = "us-east-1"
}
