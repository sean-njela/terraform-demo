# .tflint.hcl
# Purpose: Configure TFLint rules for Terraform linting.
# Docs: https://github.com/terraform-linters/tflint

# Specify the Terraform version your repo targets
terraform {
  required_version = ">= 1.13.0"
}

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
  enabled = true
  version = "0.43.0" # pin for deterministic results
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  deep_check = true   # deeper but slower analysis
}

# Terraform ruleset plugin (for general Terraform best practices)
plugin "terraform" {
  enabled = true
  # Use the recommended preset; version may be left floating or pinned
  preset = "recommended"
  version = "0.13.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}

# Optionally ignore specific rules that generate noise or false positives
ignore_rule = [
  # Example: "aws_instance_invalid_type",
  # Add any rule codes here your team deems irrelevant
]

# You can also suppress warnings by file pattern or module
# suppress_file = {
#   "module/external/*" = ["rule_code_1", "rule_code_2"]
# }