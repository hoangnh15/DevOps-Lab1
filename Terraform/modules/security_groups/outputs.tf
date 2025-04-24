# File: terraform/modules/security_groups/outputs.tf

output "public_sg_id" {
  description = "ID of the Security Group for Public EC2 instances."
  value       = aws_security_group.public_ec2_sg.id
}

output "private_sg_id" {
  description = "ID of the Security Group for Private EC2 instances."
  value       = aws_security_group.private_ec2_sg.id
}