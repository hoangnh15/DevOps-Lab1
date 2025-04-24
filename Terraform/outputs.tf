# File: terraform/outputs.tf
output "vpc_id" {
  description = "ID of the main VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of Public Subnet IDs."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of Private Subnet IDs."
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_public_ips" {
  description = "List of Public IPs for the NAT Gateways."
  value       = module.vpc.nat_public_ips
}

output "public_ec2_instance_id" {
  description = "ID of the Public EC2 Instance."
  value       = module.ec2.public_instance_id
}

output "public_ec2_public_ip" {
  description = "Public IP address of the Public EC2 Instance."
  value       = module.ec2.public_ip
}

output "private_ec2_instance_id" {
  description = "ID of the Private EC2 Instance."
  value       = module.ec2.private_instance_id
}

output "private_ec2_private_ip" {
  description = "Private IP address of the Private EC2 Instance."
  value       = module.ec2.private_ip
}

output "ssh_command_public_ec2" {
  description = "SSH command to connect to the Public EC2."
  value       = "ssh -i ${var.ec2_key_pair_name}.pem ec2-user@${module.ec2.public_ip}"
}

output "ssh_command_private_ec2_from_public" {
   description = "SSH command to connect to the Private EC2 FROM the Public EC2."
   value = "ssh -i ${var.ec2_key_pair_name}.pem ec2-user@${module.ec2.private_ip}"
}