# File: terraform/main.tf

module "vpc" {
  source = "./modules/vpc"

  project_name               = var.project_name
  vpc_cidr_block             = var.vpc_cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_groups"

  project_name = var.project_name
  my_ip        = var.my_ip
  vpc_id       = module.vpc.vpc_id # Lấy output từ module vpc
}

module "ec2" {
  source = "./modules/ec2"

  project_name      = var.project_name
  ec2_ami_id        = var.ec2_ami_id
  ec2_instance_type = var.ec2_instance_type
  ec2_key_pair_name = var.ec2_key_pair_name

  # Lấy output từ các module khác
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  private_subnet_id = module.vpc.private_subnet_ids[0]
  public_sg_id      = module.security_groups.public_sg_id
  private_sg_id     = module.security_groups.private_sg_id
}