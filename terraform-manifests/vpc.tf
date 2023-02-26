# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"
  name = var.vpc_name
  cidr = var.vpc_cidr_block
  azs = var.vpc_availability_zones
  public_subnets = var.vpc_public_subnets
  enable_dns_hostnames = true
  enable_dns_support = true
  public_subnet_tags = {
    Name = "demo-subnet"
  }
  public_route_table_tags = {
    Name = "demo-route-table"
  }
  igw_tags = {
    Name = "demo-igw"
  }
  tags = local.common_tags
}