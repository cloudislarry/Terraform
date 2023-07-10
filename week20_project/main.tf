/*
Name: Week20 Project -How to create Jenkins server on an EC2 using Terraform 
Contributor: Larry Johnson
*/

# Defines the type and size of instance being created along with which security to be used
resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data              = file("jenkins.sh")
  tags = {
    Name = "wk20_terraform_jenkins"

  }
}

# Security group being used for the above instance
resource "aws_security_group" "jenkins_sg" {
  name        = var.jenkins_sg
  description = "Security group for Jenkins instance"
  vpc_id      = var.default_vpc_id
  ingress {
    description = "Allow SSH from my Public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allows Access to the Jenkins Server"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allows Access to the Jenkins Server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Jenkins Security Group"
  }
}

# Creation of S3 bucket for Jenkins artifacts
resource "random_id" "random_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "lj-jenkins-artifacts-wk20" {
  bucket = "lj-jenkins-artifacts-${random_id.random_suffix.hex}"
}
