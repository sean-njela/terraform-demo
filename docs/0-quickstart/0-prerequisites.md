# Prerequisites

This project uses [Devbox](https://www.jetify.com/devbox/) to manage the development environment. Devbox provides a consistent, isolated environment with all the necessary CLI tools pre-installed.

## Docker

- Follow the [installation instructions](https://docs.docker.com/get-docker/) for your operating system.

The rest of the tools are already installed in the devbox environment

## Devbox

- Follow the [installation instructions](https://www.jetify.com/devbox/docs/installing_devbox/) for your operating system.

## Clone the Repository

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

## Start the Devbox Environment and poetry environment

```bash
devbox shell # Start the devbox environment (this will also start the poetry environment)
poetry install # Install dependencies
poetry env activate # use the output to activate the poetry environment ( ONLY IF DEVBOX DOES NOT ACTIVATE THE ENVIRONMENT)
```
!!!tip "Note"
    The first time you run `devbox shell`, it will take a few minutes to install the necessary tools. But after that it will be much faster.


---
