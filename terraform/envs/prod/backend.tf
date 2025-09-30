terraform {
  backend "s3" {
    bucket         = "devopssean-prod-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "devopssean-prod-terraform-state-lock"
    encrypt        = true
  }
}