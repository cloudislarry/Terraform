terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#Specify AWS Region
provider "aws" {
  region = "us-east-1"
}
