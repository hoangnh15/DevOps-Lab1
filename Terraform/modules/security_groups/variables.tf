# File: terraform/modules/security_groups/variables.tf

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where Security Groups will be created"
  type        = string
}

variable "my_ip" {
  description = "User's public IP for SSH access to Public EC2"
  type        = string
  sensitive   = true
}