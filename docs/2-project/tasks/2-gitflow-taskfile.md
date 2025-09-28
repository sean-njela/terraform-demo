# GitFlow Taskfile Overview

This page explains the structure and functionality of the `Taskfile.gitflow.yml` file, which automates a standardized Git workflow using Git Flow conventions. This taskfile is designed to simplify and formalize branching, releasing, and hotfixing in projects that follow the GitFlow methodology.

!!!tip "It is optional to use gitflow."
       If you do not want to use it, you can remove the `Taskfile.gitflow.yml` file and unlink it from the `Taskfile.yaml` file (remove the `includes` section). If you cannot find the section use `CTRL + F` to search for Taskfile.yaml.

## What is Git Flow?

[Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) is a branching strategy that separates feature development from production releases. It introduces long-lived branches like `main` and `develop`, as well as temporary branches for features, releases, and hotfixes.

## Purpose of This Taskfile

The `Taskfile.gitflow.yml` automates repetitive Git Flow actions using the `task` CLI tool. It allows you to:

- Initialize a Git Flow structure with default branches and prefixes
- Create and finish feature branches
- Create release and hotfix branches
- Push and merge code with consistent naming and flow
- Eliminate manual mistakes in branch naming or merging

This is especially useful in teams or long-running solo projects where structured release cycles are important.

## What This Taskfile Automates

Here’s a breakdown of what’s covered:

### 1. **Initialization**
- Sets up Git Flow with `main` as the production branch and `develop` for ongoing work.
- Configures standard prefixes (`feature/`, `release/`, `hotfix/`, etc.).
- Ensures required branches (`main`, `develop`) exist locally and remotely.
- Optionally initializes the `gh-pages` branch for documentation deployments.

This is typically run once at the start of the project using `task -t Taskfile.gitflow.yml init`.

### 2. **Feature Branch Management**
- Start a new feature branch from `develop`
- Finish a feature by merging it back into `develop`
- Automatically push changes to the remote
- Prevents common mistakes like forgetting to push or rebase

### 3. **Release Branch Management**
- Create a release branch off `develop`
- Optionally tag a version
- Merge into `main` and `develop`
- Clean up the release branch
- Pushes changes and tags to the remote

### 4. **Hotfix Branch Management**
- Create a hotfix directly off `main` (for production issues)
- Merge back into both `main` and `develop`
- Optionally tag the hotfix release
- Push changes and remove local branches

### 5. **Branch Cleanup and Syncing**
- Deletes local feature/release branches after merging
- Pulls and syncs remote branches as needed

## Typical Usage Flow

1. **Initialize GitFlow structure**
   ```bash
   task init
   ```

2. **Start a new feature**
   ```bash
   task feature:start name="add-login"
   ```

3. **Finish a feature**
   ```bash
   task feature:finish name="add-login"
   ```

4. **Start a release**
   ```bash
   task release:start version="1.0.0"
   ```

5. **Start a hotfix**
   ```bash
   task hotfix:start version="1.0.1"
   ```

6. **Finish a release**
   ```bash
   task release:finish version="1.0.0"
   ```

7. **Finish a hotfix**
   ```bash
   task hotfix:finish version="1.0.1"
   ```

## When Should You Use This?

Use this taskfile when:

* You want consistent branch names and GitFlow discipline
* You're working in long-lived projects that ship versioned releases
* You have documentation (e.g. via `mike`) that needs coordinated tagging
* You want to automate repetitive Git steps safely

Avoid using it if:

* Your workflow is trunk-based (i.e., no `develop`)
* You're doing rapid prototyping without versioning

## Notes

* This taskfile assumes Git is already initialized and the remote origin is set.
* It is safe to re-run `init`; it won’t overwrite existing GitFlow config.
* The file uses `{{.VAR_NAME}}` placeholders — these are defined in the task's command-line usage.
* You can see available tasks by running:

  ```bash
  task --list-all
  ```

## Related Docs

* [Main Taskfile Overview](./1-main-taskfile.md)
* [Getting Started](../../0-quickstart/1-getting-started.md)
* [Architecture](../../1-architecture/0-overview.md)

## Contact

Questions or issues with GitFlow setup? Reach out via [GitHub Issues](https://github.com/sean-njela/demo_monitoring/issues) or email at [seannjela@outlook.com](mailto:seannjela@outlook.com).
