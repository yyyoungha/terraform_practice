# Terraform data block
#   :Data sources allow Terraform to use information defined outside of Terraform, 
#   defined by another separate Terraform configuration, or modified by functions.

data "aws_vpc" "vpc_prod" {
  filter {
    name = "tag:Name"
    values = ["vpc-prod"]
  }
}

data "aws_subnet_ids" "vpc_prod" {
  vpc_id = data.aws_vpc.vpc_prod.id
  filter {
    name = "tag:Name"
    values = ["sbn-prod-cmn-private-az1a","sbn-prod-cmn-private-az1c"]
  }
}

data "aws_vpc" "vpc_cicd" {
  filter {
    name = "tag:Name"
    values = ["vpc-cicd"]
  }
}

data "aws_subnet_ids" "vpc_cicd" {
  vpc_id = data.aws_vpc.vpc_cicd.id
  filter {
    name = "tag:Name"
    values = ["sbn-cicd-cmn-private-az1a","sbn-cicd-cmn-private-az1c"]
  }
}

data "aws_subnet" "devopssubnet" {
  filter {
    name   = "tag:Name"
    values = ["sbn-cicd-cmn-private-az1a"]
  }
}

data "aws_subnet" "prdsubnet" {
  filter {
    name   = "tag:Name"
    values = ["sbn-prod-cmn-private-az1a"]
  }
}

data "aws_route_table" "rt_cicd_main" {
  filter {
    name   = "tag:Name"
    values = ["rt-cicd-main"]
  }
}

data "aws_route_table" "rt_prod_main" {
  filter {
    name   = "tag:Name"
    values = ["rt-prod-main"]
  }
}
