# uv Cheat Sheet

## Installation

```bash
# Linux / macOS
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows (PowerShell)
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# Verify install
uv --version
```

## Projects

```bash
# Create a new project in folder "myproj"
uv init myproj

# Create a new project in the current folder
uv init
```

## Dependencies

```bash
# Add a package
uv add requests

# Add a package with version
uv add django==4.2.7

# Add a development dependency
uv add --dev pytest

# Remove a package
uv remove requests
```

## Locking and Installing

```bash
# Install all dependencies into the environment (creates uv.lock if missing)
uv sync

# Update dependencies to latest allowed versions
uv sync --upgrade

# Compile lock file from requirements input
uv pip compile pyproject.toml

# Sync environment to match lock file
uv pip sync uv.lock
```

## Virtual Environments

```bash
# Create a virtual environment
uv venv

# Create with specific Python version
uv venv --python 3.11

# Show where environment is
uv venv --path
```

## Running Code

```bash
# Run Python inside environment
uv run python

# Run a script
uv run myscript.py

# Run a command with dependencies
uv run pytest
```

## Python Versions

```bash
# List installed Python versions
uv python list

# Install Python 3.11
uv python install 3.11

# Upgrade Python 3.11 to latest patch
uv python upgrade 3.11

# Show default Python
uv python pin
```

## Inspecting

```bash
# Show dependency tree
uv tree

# Show project metadata
uv project show
```

## Building and Publishing

```bash
# Build source distribution and wheel
uv build

# Publish to PyPI (requires credentials)
uv publish
```

## Tools

```bash
# Install a tool globally (example: black)
uv tool install black

# Run a tool
uv tool run black --version

# List installed tools
uv tool list

# Remove a tool
uv tool uninstall black
```

## Useful Options

```bash
# Dry run, show what would happen
--dry-run

# Use lowest compatible versions
--resolution=lowest

# Target a different Python version when resolving
--python-version 3.10
```

Correct. The cheat sheet I gave did not include `uvx`. Here is the missing section.

## `uvx` Cheat Sheet

`uvx` is a shortcut to run any Python package or script **without pre-installing it**.
It automatically downloads the package into a temporary cache, runs it, and reuses cached copies on later runs.
It is like `npx` in Node.js.

## Syntax

```bash
uvx <package> [arguments...]
```

## Examples

```bash
# Run black without installing globally
uvx black myfile.py

# Run flake8
uvx flake8 src/

# Run httpie
uvx http --version

# Run Django admin script
uvx django-admin startproject mysite
```

## Pinning Versions

```bash
# Run a specific version of black
uvx black==23.9.1 --version
```

## With Python Scripts

```bash
# Run a Python script that is not installed
uvx -m http.server 8000
```

## Notes

* `uvx` installs packages into a cache under your user directory.
* First run is slower, later runs are instant (from cache).
* If you need to clear cache:

  ```bash
  uv cache clean
  ```
* Useful for tools (linters, formatters, build helpers) you do not want in your project dependencies.
* Equivalent to `npx` in Node.js or `pipx run` in Python.

`uv tool list` will **never** show what is in `pyproject.toml`.

Two separate systems:

| Scope                    | Command                                                | What it manages                                       | Where it records state                                        |
| ------------------------ | ------------------------------------------------------ | ----------------------------------------------------- | ------------------------------------------------------------- |
| **Project dependencies** | `uv add`, `uv remove`, `uv sync`                       | The packages your project uses                        | `pyproject.toml` + `uv.lock`                                  |
| **Global tools**         | `uv tool install`, `uv tool uninstall`, `uv tool list` | Stand-alone CLI tools, like `black`, `ruff`, `httpie` | User’s tool directory (`~/.local/share/uv/tools/` by default) |

So if you want to see **project dependencies**, use:

```bash
uv tree          # dependency graph
```

If you want to see **globally installed tools**, then use:

```bash
uv tool list
```

They are intentionally kept separate.

With `uv`, you never edit `[tool.poetry.dependencies]` like in Poetry. You only use **standard PEP 621 fields** in `pyproject.toml`.

Two ways to add dependencies:

## 1. Let `uv` edit `pyproject.toml` for you

```bash
# Add a runtime dependency
uv add requests

# Add a dev dependency
uv add --dev pytest
```

This will:

* Update `pyproject.toml` under `[project]` or `[tool.uv]` (depending on context).
* Regenerate `uv.lock`.

## 2. Edit `pyproject.toml` manually

Minimal example with dependencies written by hand:

```toml
[project]
name = "myproj"
version = "0.1.0"
description = "Example project"
requires-python = ">=3.10"

dependencies = [
    "requests>=2.31",
    "flask>=2.3",
]

[tool.uv]
dev-dependencies = [
    "pytest>=7.0",
]
```

Then run:

```bash
uv sync

# List installed packages (table)
uv pip list

# Freeze environment (pip-compatible format)
uv pip freeze
```

This will install what you declared and create/update `uv.lock`.

### Key difference from Poetry

* Poetry used `[tool.poetry.dependencies]` and `[tool.poetry.dev-dependencies]`.
* uv uses the **PEP 621 standard** `[project]` section for main dependencies.
* Dev dependencies live in `[tool.uv.dev-dependencies]`.
