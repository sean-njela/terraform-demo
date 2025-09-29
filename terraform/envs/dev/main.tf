module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.4"

  name = "dev-tf-demo-vpc"
  cidr = "10.0.0.0/16"
  azs  = ["eu-central-1a", "eu-central-1b"]

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false # cheaper for dev
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.1"

  key_name           = "dev-tf-demo-keypair"
  create_private_key = true
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.1"

  name = "dev-tf-demo-instance"

  instance_type = "t3.micro"
  key_name      = "dev-tf-demo-keypair"
  monitoring    = true
  # use the first public subnet created by the VPC module
  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

