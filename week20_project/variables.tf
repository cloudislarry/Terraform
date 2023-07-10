# Specify AWS Region
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# Instance Type
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# Instance ID
variable "ami_id" {
  description = "AMI ID of instance"
  type        = string
  default     = "ami-053b0d53c279acc90"
}

# Configure your VPC 
variable "default_vpc_id" {
  description = "ID of your VPC"
  default     = "vpc-0c4942518add2b1ee"

}

# Security group name
variable "jenkins_sg" {
  description = "Jenkins_Security"
  default     = "jenkins_terraform"
}

