
resource "aws_s3_bucket" "week21-s3-larryjohnson" {
  bucket = "week21-s3-larryjohnson"

  tags = {
    Name        = "week21 S3 bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "week21-s3-larryjohnson" {
  bucket = aws_s3_bucket.week21-s3-larryjohnson.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "week21-s3-larryjohnson_access_block" {
  bucket = aws_s3_bucket.week21-s3-larryjohnson.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group to allow inbound/outbond on 8080
resource "aws_security_group" "allow_8080_and_outbound" {
  name        = "allow_8080_and_outbound"
  description = "Allow traffic on port 8080 and all inbound/outbound traffic"

  # Allow inbound traffic on port 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all inbound traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "web_server" {
  name          = "web_server"
  image_id      = var.launch_template_image_id
  instance_type = var.instance_type
  security_groups = [
    aws_security_group.allow_http.id,
    aws_security_group.allow_8080_and_outbound.id,
  ]
  key_name             = "week5"
  user_data = <<-EOF
  #!/bin/bash
  sleep 60
  yum update -y
  yum install -y httpd aws-cli
  systemctl start httpd
  systemctl enable httpd
  echo "Welcome to Shadow Corp!" > /var/www/html/index.html
  EOF
}

# Create ASG for Webserver
resource "aws_autoscaling_group" "web_server_ag" {
  name                 = "webserver_ag"
  desired_capacity     = var.min_size
  min_size             = var.min_size
  max_size             = var.max_size
  vpc_zone_identifier  = data.aws_subnets.default.ids
  launch_configuration = aws_launch_configuration.web_server.name
}