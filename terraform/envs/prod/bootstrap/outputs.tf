##############################################
# outputs.tf
# Purpose:
#   Expose backend resources and a copy-paste
#   backend block for manual creation of backend.tf
##############################################

# S3 bucket name for Terraform remote state
output "s3_bucket" {
  description = "Name of the S3 bucket for remote state"
  value       = module.terraform_state_backend.s3_bucket_id
}

# DynamoDB table name for state locking
output "dynamodb_table" {
  description = "Name of the DynamoDB table for state locking"
  value       = module.terraform_state_backend.dynamodb_table_id
}

# Region (referenced from variable, not from module)
output "region" {
  description = "AWS region for backend resources"
  value       = var.aws_region
}

# Ready-to-use backend block
output "backend_config_snippet" {
  description = "Backend configuration block for backend.tf"
  value       = <<EOT
terraform {
  backend "s3" {
    bucket         = "${module.terraform_state_backend.s3_bucket_id}"
    key            = "terraform.tfstate"
    region         = "${var.aws_region}"
    dynamodb_table = "${module.terraform_state_backend.dynamodb_table_id}"
    encrypt        = true
  }
}
EOT
}
