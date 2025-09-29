<div align="center">

  <!-- Row of icons -->
  
  <p>
    <img src="https://logo.svgcdn.com/l/terraform.svg" alt="Terraform" height="40" />
    &nbsp;&nbsp;
    <img src="https://logo.svgcdn.com/l/aws.svg" alt="AWS" height="40" />
    &nbsp;&nbsp;
    <img src="https://logo.svgcdn.com/l/hashicorp.svg" alt="HashiCorp" height="40" />
  </p>
 

  <h1>Terraform Infrastructure as Code Portfolio Project</h1>

  <p>
    Cloud Infrastructure Automation with Terraform: Modular, Secure, and Scalable Deployment
  </p>

  <p>
    <a href="https://github.com/sean-njela/terraform-demo/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/sean-njela/terraform-demo" alt="contributors" />
  </a>
  <a href="">
    <img src="https://img.shields.io/github/last-commit/sean-njela/terraform-demo" alt="last update" />
  </a>
  <a href="https://github.com/sean-njela/terraform-demo/network/members">
    <img src="https://img.shields.io/github/forks/sean-njela/terraform-demo" alt="forks" />
  </a>
  <a href="https://github.com/sean-njela/terraform-demo/stargazers">
    <img src="https://img.shields.io/github/stars/sean-njela/terraform-demo" alt="stars" />
  </a>
  <a href="https://github.com/sean-njela/terraform-demo/issues/">
    <img src="https://img.shields.io/github/issues/sean-njela/terraform-demo" alt="open issues" />
  </a>
  <a href="https://github.com/sean-njela/terraform-demo/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/sean-njela/terraform-demo.svg" alt="license" />
  </a>
  </p>
</div>

## Table of Contents

  * [Screenshots](#screenshots)
  * [Tech Stack](#tech-stack)
  * [Prerequisites](#prerequisites)
  * [Quick Start](#quick-start)
  * [Documentation](#documentation)
  * [Features](#features)
  * [Tasks (automation)](#tasks)
  * [Roadmap](#roadmap)
  * [License](#license)
  * [Contributing](#contributing)
  * [Contact](#contact)

## Screenshots

<div align="center"> 
  <img src="assets/screenshot1.png" alt="screenshot1" />
  <img src="assets/screenshot2.png" alt="screenshot2" />
</div>

<!-- 
## Demo
<a href="https://www.example.com/">
<div align="center"> 
  <img src="assets/screenshot1.png" alt="screenshot 1" />
  <img href="https://www.example.com/" src="assets/screenshot2.png" alt="screenshot 2" />
</div>
</a>

![▶ Watch a short demo](assets/demo-video-gif.gif)
[![▶ Watch a short demo](assets/demo-video-gif.gif)](https://www.example.com/)
 -->
<!-- 
[▶ Watch a short demo](assets/demo-video-small.mp4) -->

## Tech Stack

> List of tools used in the project

[![Devbox](https://www.jetify.com/img/devbox/shield_moon.svg)](https://www.jetify.com/devbox/docs/contributor-quickstart/)
![Taskfile](https://img.shields.io/badge/Taskfile-3.44.0-green)
![gitflow](https://img.shields.io/badge/gitflow-1.12-green)
![uv](https://img.shields.io/badge/uv-0.8-green)
![precommit](https://img.shields.io/badge/precommit-4.3.0-green)

## Prerequisites

> This project uses [Devbox](https://www.jetify.com/devbox/) to manage the development environment. Devbox provides a consistent, isolated environment with all the necessary CLI tools pre-installed.

0. **Install Docker**

   - Follow the [installation instructions](https://docs.docker.com/get-docker/) for your operating system.

> The rest of the tools are already installed in the devbox environment

1. **Install Devbox**

   - Follow the [installation instructions](https://www.jetify.com/devbox/docs/installing_devbox/) for your operating system.

2. **Clone the Repository**

   ```bash
   git clone https://github.com/sean-njela/terraform-demo.git
   cd terraform-demo
   ```

3. **Start the Devbox Environment and poetry environment**

   ```bash
   devbox shell # Start the devbox environment (this will also start the uv environment)
   ```
> Note - The first time you run `devbox shell`, it will take a few minutes to install the necessary tools. But after that it will be much faster.

## Quick Start

```bash
task setup

task status # check if everything is running

# GIVE EVERYTHING A MINUTE TO SETUP THEN
task dev
```

## Documentation

For full documentation, setup instructions, and architecture details, visit the [docs](docs/index.md) or run:

```bash
# Option 1
task docs

# Or if you prefer the docker version:
# Option 2
task docs-docker

# ONLY RUN ONE OF THE ABOVE
```

Docs are then available at: [http://127.0.0.1:8030/]()

## Features

* Modular Terraform configuration for AWS
* Automated local provisioning and teardown
* Environment isolation (dev, staging, production)
* Git workflow automation with Git Flow

## Tasks

> This project is designed for a simple, one-command setup. All necessary actions are orchestrated through `Taskfile.yml`.

```bash
task setup # setup the environment
task dev # automated local provisioning
task cleanup-dev # cleanup the dev environment
```

### Git Workflow with Git Flow

The `Taskfile.gitflow.yml` provides a structured Git workflow using Git Flow. This helps in managing features, releases, and hotfixes in a standardized way. To run these tasks just its the same as running any other task. Using gitflow is optional.

```bash
task init                 # Initialize Git Flow with 'main', gh-pages and 'develop'
task sync                 # Sync current branch with latest 'develop' and handle main updates
task release:finish       # Finishes and publishes a release (merges, tags, pushes). e.g task release:finish version="1.2.0"
```

To see all tasks:

```bash
task --list-all
```

If you do not want the gitflow tasks, you can remove the `Taskfile.gitflow.yml` file and unlink it from the `Taskfile.yml` file (remove the `includes` section). If you cannot find the section use CTRL + F to search for `Taskfile.gitflow.yml`.

## NOTES

> Important notes to remember whilst using the project

## Troubleshooting

For comprehensive troubleshooting, refer to the [Troubleshooting](docs/3-troubleshooting/0-overview.md) section. Or open the github pages [here](https://sean-njela.github.io/terraform-demo/3-troubleshooting/0-overview.md) and use the search bar to search your issue (USE INDIVIDUAL KEYWORDS NOT THE ISSUE NAME). 

## Roadmap

* [x] Core infrastructure setup
* [ ] Extend CI/CD integration
* [ ] Add monitoring and alerting modules

## Contributing

<a href="https://github.com/sean-njela/terraform-demo/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=sean-njela/terraform-demo" />
</a>

> Contributions welcome! Open an issue or submit a PR.

## License

Distributed under the MIT License. See `LICENSE` for more info.

## Contact

Your Name – [@linkedin](https://linkedin.com/in/sean-njela) – [@twitter/x](https://x.com/devopssean) – [seannjela@outlook.com](mailto:seannjela@outlook.com)

Project Link: [https://github.com/sean-njela/terraform-demo](https://github.com/sean-njela/terraform-demo)

About Me - [About Me](docs/4-about/0-about.md)