# region
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

# internet gateways
variable "igw_name" {
  type = string
}

# route tables
variable "route_table_name-main" {
  type = string
}
