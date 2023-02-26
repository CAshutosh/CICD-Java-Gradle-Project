# AWS EC2 Security Group Terraform Module
module "ec2-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"
  name = "ec2-security-group"
  description = "Security Group for ec2 Instance"
  vpc_id = module.vpc.vpc_id

  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 9000
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}