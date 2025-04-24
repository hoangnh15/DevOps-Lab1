# File: terraform/modules/vpc/variables.tf

variable "project_name" {
  description = "vpc devops lab1 nhom14"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for Public Subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for Private Subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of Availability Zones to use"
  type        = list(string)
}