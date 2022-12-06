resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.name
  }
}

resource "aws_main_route_table_association" "mainasso" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.rtmain.id
}

resource "aws_vpc_ipv4_cidr_block_association" "vpc" {
  count = var.secondary_cidr ? 1 : 0
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.secondary_cidr_block
}

resource "aws_vpc_ipv4_cidr_block_association" "vpc2" {
  count = var.tertiary_cidr ? 1 : 0
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.tertiary_cidr_block
}

#########################################################
# TODO - More than VPC Resources with Hard Coding
#########################################################s

#Subnet - Loop & Data Sources
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet1_cidr_block
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = var.subnet1_name
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet2_cidr_block
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = var.subnet2_name
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet3_cidr_block
  availability_zone = "ap-northeast-1a"
  depends_on = [
    aws_vpc_ipv4_cidr_block_association.vpc
  ]
  
  tags = {
    Name = var.subnet3_name
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet4_cidr_block
  availability_zone = "ap-northeast-1c"
  depends_on = [
    aws_vpc_ipv4_cidr_block_association.vpc2
  ]

  tags = {
    Name = var.subnet4_name
  }
}

resource "aws_subnet" "subnet5" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet5_cidr_block
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = var.subnet5_name
  }
}

resource "aws_subnet" "subnet6" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet6_cidr_block
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = var.subnet6_name
  }
}

# Route Table - Main
resource "aws_route_table" "rtmain" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.route_table_name-main
  }
}
