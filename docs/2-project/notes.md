# General Notes before we begin

A DevOps infrastructure repository structure must balance clarity, modularity, and separation of concerns. Mixing everything in one repository usually leads to coupling, poor security boundaries, and scaling issues.

### General principles

* Separate stateful tools (Terraform, Ansible) from stateless deployment descriptors (Helm, Argo CD).
* Keep repositories scoped to lifecycle stage and ownership.
* Keep application code repositories separate from infrastructure repositories.
* Avoid a single monolithic repository unless the team is small and the infrastructure surface area is trivial.

### Terraform repositories

**Content:**

* Providers and backend configuration (e.g. remote state, workspaces).
* Environment directories (`prod`, `staging`, `dev`) with their own variable files and state separation.
* Reusable modules in `modules/` with versioning.
* Global networking, IAM, and foundational infrastructure separate from application-level infrastructure.

**Best practice:**

* One repository for foundational infrastructure (networking, IAM, shared services).
* One repository per domain/application if isolation and blast radius matter.
* Versioned modules, consumed via Git tags or a registry.

**Risks of one repository for all:**

* Large blast radius if someone breaks main.
* Hard to isolate environments or delegate ownership.
* Longer CI/CD runs.

### Helm repositories

**Content:**

* Chart definitions for applications.
* Chart values files for each environment.
* A Helm chart repository (packaged charts hosted in an artifact registry, e.g. OCI or S3/GCS, not GitHub alone).

**Best practice:**

* Keep Helm charts separate from Terraform.
* Each application may have its chart in its own repository, or a central "charts repo" if teams are small.
* Push packaged charts to a chart registry, not Git.

### Argo CD repositories

Argo CD follows a **GitOps model**. It expects "application repositories" containing Kubernetes manifests or Helm chart references.

**Content:**

* `Application` CRDs declaring desired state.
* Environment overlays (e.g. `kustomize` overlays or Helm values).
* References to Helm chart repositories.

**Best practice:**

* Separate GitOps config repo(s) from app code repos.
* One "Argo CD apps of apps" repo for cluster bootstrapping.
* Each environment can have its own repo if desired.

### Ansible repositories

**Content:**

* Inventories (grouped by environment).
* Roles with idempotent tasks.
* Playbooks referencing roles.
* Group and host vars.

**Best practice:**

* Keep Ansible in its own repository, especially if used for configuration management outside Kubernetes (VMs, bare metal, hybrid).
* If Ansible is only used as a helper (e.g. bootstrap EC2 before Terraform takes over), it can live with Terraform in a "provisioning" repo.

### Recommended separation

* **Terraform repo(s):** infrastructure provisioning (cloud resources).
* **Helm repo(s):** application packaging.
* **Argo CD repo(s):** GitOps manifests and environment overlays.
* **Ansible repo(s):** configuration management.
* **Application repos:** contain only application code and CI/CD pipelines.

### Practical models

1. **Small team, low complexity:**

   * One infrastructure mono-repo containing Terraform, Helm charts, and Argo CD configs in separate folders.
   * Clear folder boundaries, strict CI jobs for each tool.
   * Only feasible with low headcount and strict discipline.

2. **Medium/large team, growing infra:**

   * Separate repositories per tool and purpose.
   * Terraform foundational infra repo + domain infra repos.
   * Helm charts repo or per-app repo.
   * Argo CD GitOps config repo.
   * Ansible repo (if needed).

### Notes on Atlantis for Terraform

Atlantis is an automation tool that runs Terraform plans and applies through pull requests. It enables safe collaboration and GitOps-style workflows for infrastructure.

**Core concepts:**

* Atlantis runs as a service in Kubernetes or on a VM.
* It listens for GitHub/GitLab/Bitbucket pull request webhooks.
* Workflow: Developer opens PR → Atlantis runs `terraform plan` → Reviewer sees plan → After approval, Atlantis runs `terraform apply`.
* All Terraform state backends must be remote (S3 + DynamoDB, GCS + locking, etc.). Atlantis does not store state.
* Configuration is managed in `atlantis.yaml` or `repos.yaml`.

**Best practices:**

* Run Atlantis inside Kubernetes with RBAC, network policies, and TLS.
* Do not give Atlantis direct cloud credentials; use IAM roles or workload identity.
* Use `atlantis.yaml` to define workflows per repo (e.g. different workspaces or modules).
* Enforce branch protections so only Atlantis can apply.
* Store Atlantis logs centrally for audit.

### How It Works

1. **Developer creates a PR** with Terraform code.
2. **Atlantis detects the PR** and posts a comment like:
    
    ```
    # Atlantis commands can be run by commenting below:
    - atlantis plan
    - atlantis apply
    ```
    
3. Developer comments on the PR:
    
    ```
    atlantis plan
    ```
    
4. Atlantis runs `terraform plan`, shows the output in the PR.
5. If all looks good, developer comments:
    
    ```
    atlantis apply
    ```
6. Atlantis applies the changes to the actual cloud infra.

## Terraform Command Cheat Sheet

### Initialisation and Setup

```bash
terraform init            # Initialise working directory, install providers, configure backend
terraform init -upgrade   # Upgrade provider plugins
terraform workspace list  # List workspaces
terraform workspace new <name>  # Create new workspace
terraform workspace select <name>  # Switch workspace
```

### Validation and Formatting

```bash
terraform fmt             # Auto-format .tf files
terraform validate        # Validate syntax and internal consistency
terraform providers       # List providers required by configuration
```

### Planning

```bash
terraform plan                          # Show execution plan
terraform plan -out=tfplan              # Save plan to file
terraform show tfplan                   # Show saved plan in human-readable form
terraform show -json tfplan > plan.json # Output plan in JSON
```

### Applying

```bash
terraform apply                         # Apply with interactive approval
terraform apply -auto-approve           # Apply without prompt
terraform apply tfplan                  # Apply previously saved plan
```

### Destroying

```bash
terraform destroy                       # Destroy managed infrastructure
terraform destroy -target=aws_instance.my_vm  # Destroy specific resource
```

### State Management

```bash
terraform state list                    # List resources in state
terraform state show <resource>         # Show details of one resource
terraform state rm <resource>           # Remove resource from state
terraform state mv <src> <dst>          # Move resource in state
terraform refresh                       # Sync state with real infrastructure
```

### Importing

```bash
terraform import <resource> <id>        # Import existing infra into state
```

### Output

```bash
terraform output                        # Show all outputs
terraform output <name>                 # Show specific output
terraform output -json                  # JSON output
```

### Graphing

```bash
terraform graph | dot -Tpng > graph.png # Generate dependency graph
```

## **Pre-commit Hooks: Validate Before Push**

### What is a Pre-commit Hook?

A **pre-commit hook** is a small script that runs **before you make a Git commit**. It catches issues early, before bad code gets committed or pushed.



### 👷 Use with Terraform

With Terraform, pre-commit hooks are often used to:

- Format code with `terraform fmt`
- Validate syntax with `terraform validate`
- Run security checks with `tflint`, `tfsec`, or `checkov`
- Enforce best practices (like locking provider versions)



### 🔧 How To Set It Up

1. Install [pre-commit](https://pre-commit.com/):

```bash
pip install pre-commit
```

2 Create a `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.77.0
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
      - id: terraform_tflint
```

Developer workflow (local):

```bash
pre-commit install
pre-commit run               # runs fmt, validate, tflint on changed files
```

CI workflow (strict checks):

```bash
pre-commit run --all-files --hook-stage manual
```

Now every time you run `git commit`, it will:
- Auto-format your `.tf` files
- Check syntax and linting
- Block commits if anything fails