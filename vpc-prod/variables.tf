variable "aws_region" {
  type = string
}

variable "name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "secondary_cidr_block" {
  type = string
}

variable "secondary_cidr" {
  type = bool
}

variable "tertiary_cidr_block" {
  type = string
}

variable "tertiary_cidr" {
  type = bool
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

# Internet Gateway
variable "igw_name" {
  type = string
}

# Route Table Main
variable "route_table_name-main" {
  type = string
}
