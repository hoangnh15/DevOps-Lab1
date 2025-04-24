# File: terraform/variables.tf

variable "aws_region" {
  description = "Khu vực AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "devops lab01 nhom14"
  type        = string
  default     = "devops-lab01-N14"
}

# --- Biến cho Module VPC ---
variable "vpc_cidr_block" {
  description = "Dải IP cho VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "Danh sách dải IP cho Public Subnets"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "Danh sách dải IP cho Private Subnets"
  type        = list(string)
  default     = ["10.10.101.0/24", "10.10.102.0/24"]
}

variable "availability_zones" {
  description = "Danh sách Availability Zones sử dụng"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# --- Biến cho Module Security Groups ---
variable "my_ip" {
  description = "Địa chỉ IP Public để cho phép SSH vào Public EC2"
  type        = string
  default     = "14.191.86.6/32"
  sensitive   = true
}

# --- Biến cho Module EC2 ---
variable "ec2_instance_type" {
  description = "Loại máy ảo EC2"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami_id" {
  description = "AMI ID cho EC2"
  type        = string
  default     = "ami-084568db4383264d4"
}

variable "ec2_key_pair_name" {
  description = "Tên Key Pair đã tạo trên AWS Console"
  type        = string
  default     = "N14-Lab1" 
}