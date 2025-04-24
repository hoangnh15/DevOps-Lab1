# File: terraform/modules/vpc/outputs.tf

output "vpc_id" {
  description = "The ID of the VPC created by this module."
  value       = aws_vpc.module_vpc.id
}

output "public_subnet_ids" {
  description = "List of IDs of the public subnets created."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of the private subnets created."
  value       = aws_subnet.private[*].id
}

output "nat_public_ips" {
  description = "List of public IPs allocated to the NAT Gateways."
  value       = aws_eip.nat[*].public_ip
}