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

##############################################
# main.tf
# Purpose:
#   Bootstrap an S3 bucket and DynamoDB table
#   to serve as the remote backend for Terraform.
#
# Module used:
#   cloudposse/tfstate-backend/aws
#
# Notes:
#   - This file is only needed once per environment.
#   - Backend configuration cannot use variables or outputs,
#     so the module generates a `backend.tf` file automatically.
##############################################
# Remote State Backend Module
#
# This module provisions:
# - A versioned and encrypted S3 bucket for storing
#   `terraform.tfstate`
# - A DynamoDB table to manage Terraform state locks
# - A `backend.tf` file that defines the S3 backend
#
# Critical design notes:
# - `namespace`, `stage`, `name` follow the Cloud Posse
#   label convention to guarantee globally unique and
#   descriptive resource names.
# - `attributes` can be appended for additional uniqueness
#   (here we use "state" to clarify the purpose).
# - `force_destroy` is set to `false` to prevent accidental
#   deletion of state history.
# - `terraform_backend_config_file_path` is set to "."
#   so that the module writes `backend.tf` into the project root.
#   Terraform will later read this automatically.
##############################################
module "terraform_state_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.7.0" # Pin to avoid drift when the module updates

  ##############################################
  # Naming convention (namespace-stage-name-attributes)
  # Example result: "eg-dev-terraform-state"
  ##############################################
  namespace  = var.bootstrap_namespace  # Organisation or project prefix
  stage      = var.bootstrap_stage      # Environment identifier (dev/staging/prod)
  name       = var.bootstrap_name       # Component name (here: terraform backend)
  attributes = var.bootstrap_attributes # Extra label to clarify resource purpose

  ##############################################
  # Backend file output
  # Ensures a backend.tf file is generated in the root directory.
  # This file contains the `backend "s3"` configuration block.
  ##############################################
  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = var.tfbackend_file

  ##############################################
  # Safety controls
  # - force_destroy = false means the S3 bucket cannot be
  #   destroyed if it contains objects. This prevents loss
  #   of Terraform state history.
  ##############################################
  force_destroy = var.force_destroy

  ##############################################
  # Optional settings (commented)
  #
  # Enable replication for DR:
  # s3_replication_enabled = true
  # s3_replica_bucket_arn  = "arn:aws:s3:::eg-dev-terraform-tfstate-replica"
  ##############################################
}
