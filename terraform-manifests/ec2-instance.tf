# AWS EC2 Instance Terraform Module
# EC2 Instance that will be created in VPC Public Subnet

module "ec2_instances" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = { for cfg in local.instance_configurations : cfg.name => cfg }

  name = each.value.name
  ami           = data.aws_ami.amzlinux2.id
  instance_type = each.value.instance_type
  key_name      = "devops-project-keypair"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.ec2-security-group.security_group_id]
  tags = local.common_tags
  user_data = each.value.user_data
}