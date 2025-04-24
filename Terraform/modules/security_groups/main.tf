# File: terraform/modules/security_groups/main.tf

# Public EC2 Security Group
resource "aws_security_group" "public_ec2_sg" {
  name        = "${var.project_name}-public-ec2-sg"
  description = "Allow SSH from user IP and all outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from user IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # Only allow SSH from the specified user IP
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-public-ec2-sg"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-SG"
  }
}

# Private EC2 Security Group
resource "aws_security_group" "private_ec2_sg" {
  name        = "${var.project_name}-private-ec2-sg"
  description = "Allow SSH from public SG and all outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from Public SG"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    # Allow traffic only from instances belonging to the public_ec2_sg
    security_groups = [aws_security_group.public_ec2_sg.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allows connection to NAT Gateway etc.
  }

  tags = {
    Name        = "${var.project_name}-private-ec2-sg"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-SG"
  }
}