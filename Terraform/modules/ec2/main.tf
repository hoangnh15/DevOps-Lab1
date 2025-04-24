# File: terraform/modules/ec2/main.tf

# Public EC2 Instance
resource "aws_instance" "public_ec2" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.public_subnet_id  
  key_name                    = var.ec2_key_pair_name
  vpc_security_group_ids      = [var.public_sg_id]     
  associate_public_ip_address = true         

  tags = {
    Name        = "${var.project_name}-public-ec2"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-EC2"
    Tier        = "Public"
  }
}

# Private EC2 Instance
resource "aws_instance" "private_ec2" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.private_subnet_id 
  key_name                    = var.ec2_key_pair_name
  vpc_security_group_ids      = [var.private_sg_id] 
  associate_public_ip_address = false

  tags = {
    Name        = "${var.project_name}-private-ec2"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-EC2"
    Tier        = "Private"
  }
}