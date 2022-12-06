resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.name
  }
}

# subnet1 - private common1
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet1_cidr_block
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = var.subnet1_name
  }
}

# subnet2 - private common2
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet2_cidr_block
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = var.subnet2_name
  }
}

# subnet3 - private app1
resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet3_cidr_block
  availability_zone = "ap-northeast-1a"
  
  tags = {
    Name = var.subnet3_name
  }
}

# subnet4 - private app2
resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet4_cidr_block
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = var.subnet4_name
  }
}

# route table main (for common subnets)
resource "aws_route_table" "rtmain" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = var.route_table_name-main
  }
}

# route table association (for common subnets)
resource "aws_main_route_table_association" "mainasso" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.rtmain.id
}

# route table association (for app subnets)
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.rtmain.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.rtmain.id
}
