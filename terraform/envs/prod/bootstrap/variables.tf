# bool
variable "nat_gateway" {
  type = bool
}
variable "vpn_gateway" {
  type = bool
}
# variable "private_key" {
#   type = bool
# }
# variable "monitoring" {
#   type = bool
# }
variable "force_destroy" {
  type = bool
}

# string
variable "vpc_name" {
  type = string
}
# variable "keypair_name" {
#   type = string
# }
# variable "ec2_name" {
#   type = string
# }
# variable "instance_type" {
#   type = string
# }
variable "vpc_cidr" {
  type = string
}
variable "aws_region" {
  type = string
}
# variable "ami" {
#   type = string
# }
variable "tfbackend_file" {
  type = string
}
variable "bootstrap_namespace" {
  type = string
}
variable "bootstrap_stage" {
  type = string
}
variable "bootstrap_name" {
  type = string
}

# list(string)
variable "availability_zones" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "bootstrap_attributes" {
  type = list(string)
}

# map(string)
variable "tags" {
  type = map(string)
}

