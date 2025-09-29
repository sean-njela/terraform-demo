# Purpose: Configure TFLint rules for Terraform linting.
# Docs: https://github.com/terraform-linters/tflint

# Enable core rules for best practices
rule "terraform_required_version" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

# Plugin for AWS (replace if using GCP/Azure/etc.)
plugin "aws" {
  enabled    = true
  version    = "0.43.0" # pin for deterministic results
  source     = "github.com/terraform-linters/tflint-ruleset-aws"
  deep_check = true     # deeper but slower analysis
}

# Terraform ruleset plugin (general best practices)
plugin "terraform" {
  enabled = true
  preset  = "recommended"
  version = "0.13.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}

# Disable noisy or irrelevant rules by marking them directly
rule "aws_instance_invalid_type" {
  enabled = false
}

rule "aws_instance_invalid_key_name" {
  enabled = false
}