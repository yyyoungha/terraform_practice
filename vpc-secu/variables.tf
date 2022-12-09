variable "aws_region" {
  type = string
}

# vpc
variable "name" {
  type = string
}

variable "cidr_block" {
  type = string
}

# subnets
variable "subnet1_name" {
  type = string
}

variable "subnet1_cidr_block" {
  type = string
}

variable "subnet2_name" {
  type = string
}

variable "subnet2_cidr_block" {
  type = string
}

variable "subnet3_name" {
  type = string
}

variable "subnet3_cidr_block" {
  type = string
}

variable "subnet4_name" {
  type = string
}

variable "subnet4_cidr_block" {
  type = string
}

variable "subnet5_name" {
  type = string
}

variable "subnet5_cidr_block" {
  type = string
}

variable "subnet6_name" {
  type = string
}

variable "subnet6_cidr_block" {
  type = string
}

# internet gateways
variable "igw_name" {
  type = string
}

# route table main
variable "route_table_name-main" {
  type = string
}

# route table
variable "route_table_name" {
  type = string
}

# transit gateway
variable "tgw_name" {
  type = string
}

# Transit Gateway Attachment : vpc-prod
variable "tgw_attach_name0" {
  type = string
}

# Transit Gateway Attachment : vpc-prod
variable "tgw_attach_name1" {
  type = string
}

# Transit Gateway Attachment : vpc-cicd
variable "tgw_attach_name2" {
  type = string
}

# Transit Gateway Route Table : vpc-prod
variable "tgw_rtable_name0" {
  type = string
}

# Transit Gateway Route Table : vpc-prod
variable "tgw_rtable_name1" {
  type = string
}

# Transit Gateway Route Table : vpc-cicd
variable "tgw_rtable_name2" {
  type = string
}
