# File: terraform/modules/vpc/main.tf

# 1. VPC Resource
resource "aws_vpc" "module_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.project_name}-vpc"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-VPC"
  }
}

# 2. Subnets (Public and Private)
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = aws_vpc.module_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.project_name}-public-subnet-${count.index + 1}"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-VPC"
    Tier        = "Public"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.module_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.project_name}-private-subnet-${count.index + 1}"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-VPC"
    Tier        = "Private"
  }
}

# 3. Internet Gateway (IGW)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name        = "${var.project_name}-igw"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-VPC"
  }
}

# 4. Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.module_vpc.id
  route {
    cidr_block = "0.0.0.0/0"             # Route to Internet
    gateway_id = aws_internet_gateway.gw.id # Via Internet Gateway
  }
  tags = {
    Name        = "${var.project_name}-public-rtb"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-VPC"
    Tier        = "Public"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# 5. Elastic IP for NAT Gateway (Required for NAT GW)
resource "aws_eip" "nat" {
  count = length(var.availability_zones) 
  vpc   = true
  tags = {
    Name        = "${var.project_name}-nat-eip-${count.index + 1}"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-VPC"
  }
  depends_on = [aws_internet_gateway.gw]
}

# 6. NAT Gateway
resource "aws_nat_gateway" "nat" {
  count         = length(var.availability_zones) # One NAT GW per AZ
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id # Place NAT GW in the corresponding Public Subnet
  tags = {
    Name        = "${var.project_name}-nat-gw-${count.index + 1}"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-VPC"
  }
  depends_on = [aws_eip.nat] # Ensure EIP is created first
}

# 7. Private Route Tables
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidr_blocks) # One RT per AZ/Private Subnet group
  vpc_id = aws_vpc.module_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"                       # Route to Internet
    nat_gateway_id = aws_nat_gateway.nat[count.index].id # Via NAT Gateway in the same AZ
  }
  tags = {
    Name        = "${var.project_name}-private-rtb-${count.index + 1}"
    Project     = var.project_name
    ManagedBy   = "Terraform-Module-VPC"
    Tier        = "Private"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id # Associate with the corresponding private RT
}

