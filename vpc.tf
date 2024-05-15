# VPC
resource "aws_vpc" "terra-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terra-vpc"
  }
}

# Subnet (Corrected VPC reference)
resource "aws_subnet" "public" {
  vpc_id         = aws_vpc.terra-vpc.id  # Corrected VPC reference
  cidr_block     = "10.0.1.0/24"
  availability_zone = "ap-south-1"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "terra-igw" {
  vpc_id = aws_vpc.terra-vpc.id
  tags = {
    Name = "terra-igw"
  }
}

# Route Table
resource "aws_route_table" "terra-route" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-igw.id
  }

  tags = {
    Name = "terra-route"
  }
}

# Route Table Association
resource "aws_route_table_association" "terra-vpc-pub-route-association" {
  subnet_id         = aws_subnet.public.id
  route_table_id     = aws_route_table.terra-route.id
}

# Security Group (**Modify rules for specific access** )
resource "aws_security_group" "terra-vpc-sg" {
  name        = "terra-vpc-sg"
  description = "Security Group for VPC Resources (**Modify rules for specific access**)"
  vpc_id      = aws_vpc.terra-vpc.id

  tags = {
    Name = "allow_tls"
  }
}

# Security Group Rules (**Modify for specific needs** )
# ... (Define specific ingress and egress rules here based on your requirements)







