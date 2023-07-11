variable "aws_region" {
  description = "AWS region resources are deployed"
  default     = "us-east-1"
  type        = string
}

# variable "instance_type" {
#   description = "The instance type for the EC2 instances"
#   default     = "t2.micro"
# }

# variable "min_size" {
#   description = "The minimum number of instances in the Auto Scaling group"
#   default     = 2
# }

# variable "max_size" {
#   description = "The maximum number of instances in the Auto Scaling group"
#   default     = 5
# }

# variable "backend_bucket_name" {
#   description = "The name of the S3 bucket to use as the backend for storing Terraform state"
#   default     = "week21"
# }