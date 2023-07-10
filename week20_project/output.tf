output "public_url" {
    description = "Public URL for Jenkins Server"
    value = "http://${aws_instance.jenkins.public_ip}:8080"
  
}