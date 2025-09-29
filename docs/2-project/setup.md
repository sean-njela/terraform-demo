# Setup

The effective folder structure:

```bash
.
│
├── .pre-commit-config.yaml   # pre-commit hooks
├── .tflint.hcl               # TFLint rules
├── .checkov.yml              # Checkov config
├── .infracost.yml            # Infracost config
├── .trivyignore              # Trivy ignores
│
├── modules/                  # reusable Terraform modules
├── envs/                     # per-environment configs
│   ├── dev/
│   ├── staging/
│   └── prod/
└── main.tf
```

