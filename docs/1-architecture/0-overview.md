# System Architecture Overview

This section provides a high-level overview of the architecture and design decisions behind the project. It outlines the system's core components, their responsibilities, and how they interact.

## Design Philosophy

Summarise your approach or values. Examples:

- Modular and composable
- Secure by default
- Automation-first (e.g., IaC, CI/CD)
- Portable/local-dev friendly

## Core Components

### 1. Infrastructure

- Describe how infrastructure is provisioned (e.g., Terraform, Pulumi)
- Where it's deployed (e.g., local Kind cluster, cloud, etc.)
- Example:
  - **Kind** cluster created via `task dev`
  - **Terraform** used to manage Argo CD and related resources

### 2. CI/CD

- What tools handle deployment?
- Example:
  - **Argo CD** handles Kubernetes app delivery using the **App of Apps** pattern
  - Image updates via **argocd-image-updater**
  - Optional notification layer (e.g., Slack integration)

### 3. Secrets & Configuration

- Mention secret handling (e.g., Sealed Secrets, SOPS, Vault)
- Config management tools (e.g., Helm, Kustomize)

## Architecture Diagram

Add a visual overview of your system if available.

![System Diagram](../assets/architecture-diagram.png)

If not available yet, note:

*Architecture diagram to be added in a future update.*

## Data / Control Flow

Explain the high-level lifecycle or data flow:

1. User runs `task dev`
2. Terraform provisions resources
3. Argo CD bootstraps itself and deploys other apps
4. Image updater checks container registries and pushes updates
5. Notifications triggered via webhook → Slack

## Related Pages

* [Quickstart: Getting Started](../0-quickstart/1-getting-started.md)
* [Topics / Application Layer](../2-project/0-topic1.md)
* [Taskfile Automation](../2-project/tasks/0-overview.md)
