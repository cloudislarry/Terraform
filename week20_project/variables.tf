variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  description = "AMI ID of instance"
  type        = string
  default     = "ami-053b0d53c279acc900"
}