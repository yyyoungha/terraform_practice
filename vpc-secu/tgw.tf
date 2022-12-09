# Transit Gateway
resource "aws_ec2_transit_gateway" "tgw" {
  description = "example"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = var.tgw_name
  }
}

# Transit Gateway Attachment - secu
resource "aws_ec2_transit_gateway_vpc_attachment" "tgwattach0" {
  subnet_ids         = [aws_subnet.subnet3.id,aws_subnet.subnet4.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = var.tgw_attach_name0
  }
}

# Transit Gateway Attachment - prod
resource "aws_ec2_transit_gateway_vpc_attachment" "tgwattach1" {
  subnet_ids         = tolist(data.aws_subnet_ids.vpc_prod.ids)
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = data.aws_vpc.vpc_prod.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = var.tgw_attach_name1
  }
}

# Transit Gateway Attachment - cicd
resource "aws_ec2_transit_gateway_vpc_attachment" "tgwattach2" {
  subnet_ids         = tolist(data.aws_subnet_ids.vpc_cicd.ids)
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = data.aws_vpc.vpc_cicd.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = var.tgw_attach_name2
  }
}

# Transit Gateway Route Table - secu
resource "aws_ec2_transit_gateway_route_table" "tgrtable0" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = var.tgw_rtable_name0
  }
}

# Transit Gateway Route Table - prod
resource "aws_ec2_transit_gateway_route_table" "tgrtable1" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = var.tgw_rtable_name1
  }
}

# Transit Gateway Route Table - cicd
resource "aws_ec2_transit_gateway_route_table" "tgrtable2" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = var.tgw_rtable_name2
  }
}

# associate secu -> tgw (secu route table)
resource "aws_ec2_transit_gateway_route_table_association" "rtasso0" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach0.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable0.id
}

# propagate tgw -> secu (secu route table)
resource "aws_ec2_transit_gateway_route_table_propagation" "rtprop0" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach0.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable0.id
}

# propagate tgw -> prod (secu route table)
resource "aws_ec2_transit_gateway_route_table_propagation" "rtprop1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable0.id
}

# propagate tgw -> cicd (secu route table)
resource "aws_ec2_transit_gateway_route_table_propagation" "rtprop2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable0.id
}

# associate prod -> tgw (prod route table)
resource "aws_ec2_transit_gateway_route_table_association" "rtasso1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable1.id
}

# associate cicd -> tgw (cicd route table)
resource "aws_ec2_transit_gateway_route_table_association" "rtasso2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable2.id
}

# propagate tgw -> secu (prod route table)
resource "aws_ec2_transit_gateway_route_table_propagation" "rtprop4" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach0.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable1.id
}

# propagate tgw -> secu (cicd route table)
resource "aws_ec2_transit_gateway_route_table_propagation" "rtprop6" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach0.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable2.id
}

# vpc-prod to blackhole
resource "aws_ec2_transit_gateway_route" "route1" {
  destination_cidr_block         = "10.0.0.0/8"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable1.id
}

# vpc-prod to internet
resource "aws_ec2_transit_gateway_route" "route3" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach0.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable1.id
}

# vpc-cicd to blackhole
resource "aws_ec2_transit_gateway_route" "route2" {
  destination_cidr_block         = "10.0.0.0/8"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable2.id
}

# vpc-cicd to internet 
resource "aws_ec2_transit_gateway_route" "route4" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwattach0.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrtable2.id
}
