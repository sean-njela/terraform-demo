<div align="center">

  <p>
    <img src="https://logo.svgcdn.com/l/terraform.svg" alt="Terraform" height="35" />
  </p>

  <h1>Terraform Infrastructure as Code Portfolio Project</h1>

  <p>
    Modular AWS Infrastructure with Terraform: Automated, Secure, and Scalable
  </p>

  <p>
    <a href="https://github.com/sean-njela/terraform-demo/graphs/contributors">
      <img src="https://img.shields.io/github/contributors/sean-njela/terraform-demo" alt="contributors" />
    </a>
    <a href="https://github.com/sean-njela/terraform-demo/commits/master">
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

## Tech Stack

[![Devbox](https://www.jetify.com/img/devbox/shield_moon.svg)](https://www.jetify.com/devbox/docs/contributor-quickstart/)
![Taskfile](https://img.shields.io/badge/Taskfile-3.44.0-green)
![gitflow](https://img.shields.io/badge/gitflow-1.12-green)
![uv](https://img.shields.io/badge/uv-0.8-green)
![precommit](https://img.shields.io/badge/precommit-4.3.0-green)

## Features
* Modular Terraform configuration for AWS
* Automated provisioning and teardown
* Environment isolation (dev, staging, production)
* Git workflow automation with Git Flow

## Prerequisites

> [!IMPORTANT]
> This project uses **Devbox** to provide a consistent development environment.

1. **Install Docker**
   [Docker installation guide](https://docs.docker.com/get-docker/)

2. **Install Devbox**
   [Devbox installation guide](https://www.jetify.com/devbox/docs/installing_devbox/)

3. **Clone the repository**
   ```bash
   git clone https://github.com/sean-njela/terraform-demo.git
   cd terraform-demo
   ```

4. **Start Devbox shell**

   ```bash
   devbox shell
   ```

   First run may take several minutes to install tools.

5. **Configure AWS IAM**
   The project uses Terraform Cloud. Ensure your IAM role is set up.
   See [setup docs](https://sean-njela.github.io/terraform-demo/0.1.1/2-project/setup/#setting-things-up).

## Quick Start

```bash
task setup
task status   # check if everything is running
task dev      # start development stack
task cleanup-dev
```

## Documentation

Full documentation is in [docs](docs/index.md). Run locally with:

```bash
task docs
```

Then open: [http://127.0.0.1:8030/](http://127.0.0.1:8030/)

## Tasks (Automation)

> [!IMPORTANT]
> This project is designed for a simple, one-command setup. All necessary actions are orchestrated through `Taskfile.yml`.

The `Taskfile.gitflow.yml` provides a structured Git workflow using Git Flow. This helps in managing features, releases, and hotfixes in a standardized way. To run these tasks just its the same as running any other task. Using gitflow is optional.

To see all tasks:

```bash
task --list-all
```

If you do not want the gitflow tasks, you can remove the `Taskfile.gitflow.yml` file and unlink it from the `Taskfile.yml` file (remove the `includes` section). If you cannot find the section use CTRL + F to search for `Taskfile.gitflow.yml`.

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

Distributed under the MIT License. See `LICENSE`.

## Contact

* [LinkedIn](https://linkedin.com/in/sean-njela)
* [Twitter/X](https://x.com/devopssean)
* [seannjela@outlook.com](mailto:seannjela@outlook.com)
* [About Me](docs/4-about/0-about.md)