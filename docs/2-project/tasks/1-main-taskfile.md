# Main Taskfile Overview

This section describes the purpose and layout of the main `Taskfile.yml` used in this project. The Taskfile defines automation tasks to simplify development workflows and ensure consistency across environments.

## Purpose of This Taskfile

This Taskfile provides command-line shortcuts for tasks like:

- Project setup
- Development environment bootstrapping
- Application deployment
- Local documentation serving
- Cleanup and teardown

It abstracts repetitive shell commands into named tasks you can run with:

```bash
task <task-name>
```

## Core Sections

### 1. **Setup & Initialization**

Includes tasks for:

* Installing dependencies
* Setting up local development tools
* Generating keys or configs (if applicable)

### 2. **Development Workflow**

Common tasks for:

* Starting local services or dev containers
* Running dev servers
* Applying Kubernetes configs or local manifests
* Watching for file changes

### 3. **Documentation**

Tasks to:

* Serve documentation locally (e.g., MkDocs)
* Build or deploy docs (if using GitHub Pages or mike)

### 4. **Deployment & Automation**

Tasks may automate:

* Building and pushing Docker images
* Running linters or formatters
* Applying infrastructure changes (e.g., with Terraform)

### 5. **Cleanup & Teardown**

Includes safe commands to:

* Tear down local clusters or containers
* Remove generated files or environments
* Reset state for fresh runs



## Typical Usage Flow

A typical flow using this Taskfile might look like:

* Set up your environment:

   ```bash
   task setup
   ```

* Start development:

   ```bash
   task dev
   ```

* Serve documentation:

   ```bash
   task docs
   ```

* Clean up:

   ```bash
   task cleanup
   ```

## Notes

* To list all available tasks:

  ```bash
  task --list-all
  ```

* Variables and flags can be passed to tasks like so:

  ```bash
  task my-task <var>=<value>
  ```

* You can structure task dependencies using `deps:` and reuse shell logic cleanly across environments.

## Tips

| Key | Description |
|  |  |
| dotenv + env: | auto-load .env files and allow task-specific overrides. |
| vars: | static or dynamic variables (via shell) for templated substitution. |
| prompt: | even for setup or prod, ask user before proceeding. |
| preconditions: | enforce environment state before running. |
| deps: | define ordering (serial) via deps for safety and repeatability. |
| internal: | hide helper tasks from user listings. |
| platforms: | restrict tasks to specific OS/arch. |
| requires: | enforce required input variables. |
| status: | skip tasks if outputs already exist. |

## Related Docs

* [GitFlow Taskfile](./2-gitflow-taskfile.md)
* [Getting Started](../../0-quickstart/1-getting-started.md)
* [Architecture Overview](../../1-architecture/0-overview.md)

## Contact

For issues or suggestions related to automation and task structure, open an issue or contact the maintainer at [seannjela@outlook.com](mailto:seannjela@outlook.com).
