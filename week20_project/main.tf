# Week 20 project, create Jenkins server using Terraform

#Resource Block

resource "aws_instance" "jenkins" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "wk20TerraformJenkins"
  }
}

