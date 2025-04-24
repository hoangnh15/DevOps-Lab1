# File: terraform/modules/ec2/variables.tf

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "ec2_ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "ec2_key_pair_name" {
  description = "Name of the EC2 Key Pair for SSH access"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet for the public EC2 instance"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet for the private EC2 instance"
  type        = string
}

variable "public_sg_id" {
  description = "ID of the Security Group for the public EC2 instance"
  type        = string
}

variable "private_sg_id" {
  description = "ID of the Security Group for the private EC2 instance"
  type        = string
}