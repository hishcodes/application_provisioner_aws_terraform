output "ec2_public_ip" {
  description = "EC2 public IP is : "
  value       = aws_instance.my_instance.public_ip
}

