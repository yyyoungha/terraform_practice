# VPC
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

# subnets
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
  
  tags = {
    Name = var.subnet3_name
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet4_cidr_block
  availability_zone = "ap-northeast-1c"

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

# Internet Gateway
resource "aws_internet_gateway" "sample" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Elastic IP
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "eip-secu-nat"
  }
}

# Nat Gateway #1
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet1.id
  depends_on = [aws_internet_gateway.sample]

  tags = {
    Name = "ngw-secu"
  }
}

# Route Table - Main
resource "aws_route_table" "rtmain" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "10.0.0.0/8"
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = var.route_table_name-main
  }
}

# Route Table - PUB
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample.id
  }
  route {
    cidr_block = "10.0.0.0/8"
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }  

  tags = {
    Name = var.route_table_name
  }
}

# Route Table Association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

# Route Table Association
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route" "tgwrt1" {
  route_table_id            = data.aws_route_table.rt_cicd_main.id
  destination_cidr_block    = "0.0.0.0/0"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "tgwrt2" {
  route_table_id            = data.aws_route_table.rt_prod_main.id
  destination_cidr_block    = "0.0.0.0/0"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}
