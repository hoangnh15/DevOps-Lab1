# File: terraform/modules/ec2/outputs.tf

output "public_instance_id" {
  description = "ID of the Public EC2 instance."
  value       = aws_instance.public_ec2.id
}

output "public_ip" {
  description = "Public IP address of the Public EC2 instance."
  value       = aws_instance.public_ec2.public_ip
}

output "private_instance_id" {
  description = "ID of the Private EC2 instance."
  value       = aws_instance.private_ec2.id
}

output "private_ip" {
  description = "Private IP address of the Private EC2 instance."
  value       = aws_instance.private_ec2.private_ip
}