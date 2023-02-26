# Input Variables

variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "vpc_name" {
  description = "VPC Name"
  type = string
  default = "demo-vpc"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type = list(string)
  default = ["us-east-1a"]
}

variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type = list(string)
  default = [ "10.0.101.0/24" ]
}

