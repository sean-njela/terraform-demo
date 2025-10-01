module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.4"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = var.availability_zones

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = var.nat_gateway
  enable_vpn_gateway = var.vpn_gateway

  tags = var.tags
}


module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.1"

  key_name           = var.keypair_name
  create_private_key = var.private_key
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.1"

  name = var.ec2_name

  instance_type = var.instance_type
  ami           = var.ami
  key_name      = var.keypair_name
  monitoring    = var.monitoring
  # use the first public subnet created by the VPC module
  subnet_id = module.vpc.public_subnets[0]

  tags = var.tags
}

