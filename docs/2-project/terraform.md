# Terraform Essentials for DevOps

### Core Blocks

These are the most important Terraform configuration blocks for DevOps tasks:

- **`provider`**

Defines the infrastructure platform (e.g., AWS, Azure, GCP).

- **`resource`**

Provisions infrastructure components like servers, databases, and networks.

- **`variable`**

Declares input values to parameterise configurations.

- **`output`**

Exposes values (like IP addresses, URLs) after deployment.

- **`module`**

Organises and reuses Terraform configurations for better structure and DRY code.


- **`locals`**

Defines local values to simplify expressions and avoid repetition.


### Sometimes Used

- **`data`**

Retrieves existing resources from the provider (e.g., latest AMI, existing VPC).

- **`terraform`**

Configures backend settings (e.g., for remote state storage with S3, GCS).


## Cheat Sheet

### Provider

Defines the cloud or infrastructure platform.

```hcl
provider "aws" {
    region = var.aws_region
}

```

### Resource

Creates and manages infrastructure components.

```hcl
resource "aws_instance" "web" {
    ami           = var.ami_id
    instance_type = var.instance_type
    tags = {
    Name = "web-server"
    }
}

```

### Variable

Allows configuration reuse and customization.

```hcl
variable "instance_type" {
    type    = string
    default = "t2.micro"
}

```

Usage:

```hcl
instance_type = var.instance_type

```

### Output

Exposes values after deployment.

```hcl
output "web_ip" {
    value = aws_instance.web.public_ip
}

```

### Module

Organises and reuses configuration.

```hcl
module "vpc" {
    source = "./modules/vpc"
    cidr   = var.vpc_cidr
}

```

### Locals

Simplifies logic and avoids repetition.

```hcl
locals {
    subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 8, 1),
    cidrsubnet(var.vpc_cidr, 8, 2),
    ]
}

```

### Data Source

Pulls in external or existing infrastructure.

```hcl
data "aws_ami" "ubuntu" {
    most_recent = true
    owners      = ["099720109477"]
    filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

```

### Terraform Block

Configures version and remote state settings.

```hcl
terraform {
    required_version = ">= 1.0.0"
    backend "s3" {
    bucket         = "tf-state-bucket"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tf-lock"
    }
}

```

### Quick Glossary

| Block | Purpose |
| --- | --- |
| `provider` | Defines infrastructure platform |
| `resource` | Creates/manages infra components |
| `variable` | Declares configurable values |
| `output` | Exposes outputs from applied infrastructure |
| `module` | Reuses organized code modules |
| `locals` | Stores computed values for reuse |
| `data` | Fetches existing resources |
| `terraform` | Configures backend and versioning |

### DevOps Pro Tips

- Use **remote state** with locking in team settings (`terraform` block).
- Break infrastructure into **modules** for reuse and clarity.
- Always **pin versions** of Terraform and providers.
- Use `data` to **avoid bloating state** with existing infra.
- Apply **consistent naming** for better collaboration.

![Screenshot of Terraform File Structure setups](../assets/tf-file-structure.png)

Version 3 - Each TF module in its own git repo with versioning (typical repo name: `terraform-{provider}-{module}` (e.g `terraform-aws-vpc`).

Then inside you would have the normal TF files → main, variables, outputs, versions, etc.

Then, after git commit, you `git tag x.x.x`, then push with `-- tags`. Now, in the main of each module, reference the git link with the tag as a source in the module resource

When changes are made to the module, push with a new version number. This can get cumbersome if there are too many repo modules so it's best to use reuseable modules across the microservices.

![Screenshot of Terraform Gotchas](../assets/tf-gotchas.png)
![Screenshot of Terraform Gotchas](../assets/tf-static-checks.png)

## My current Stack

### Local Development

| Layer | Tool/Component | Purpose |
| --- | --- | --- |
| **Local Backend** | `local` backend | Stores Terraform state files locally for isolated development. |
| **Workspaces** | Terraform Workspaces | Manages multiple environments (e.g., dev, test) within the same config. |
| **Mock Providers** | LocalStack, Docker | Simulates cloud services locally for testing without incurring costs. |
| **Testing Framework** | Terratest or `terraform plan` in CI | Facilitates automated testing of Terraform modules and configurations. |
| **Linting & Formatting** | `tflint`, `terraform fmt` | Ensures code quality and adherence to best practices. |

### Production

| Layer | Tool/Component | Purpose |
| --- | --- | --- |
| **Remote Backend** | S3 + DynamoDB (AWS) or Terraform Cloud (free tier) | Stores state files remotely with locking and versioning capabilities. |
| **Version Control** | GitHub, GitLab | Manages infrastructure code and enables collaboration. |
| **CI/CD Integration** | GitHub Actions | Automates testing and deployment of infrastructure changes. |
| **Secrets Management** | AWS Secrets Manager | Secures sensitive information used in configurations. |
| **Policy Enforcement** | OPA (with Conftest) | Enforces compliance and governance policies on infrastructure changes. |
| **Monitoring & Alerts** | Basic CloudWatch / Prometheus exporters | Monitors infrastructure health and performance. |