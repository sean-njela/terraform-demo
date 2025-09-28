# Getting Started

Welcome! This section will walk you through how to get the project up and running on your local machine or development environment.

## Prerequisites

Before you begin, ensure you have the following installed all the requirements. See the [Prerequisites](./0-prerequisites.md) section for detailed instructions on installing these tools.

## Walkthrough

After everything is wired up, you can run the following commands:

```bash
task setup

task status # check if everything is running

# GIVE EVERYTHING A MINUTE TO SETUP THEN
task dev
```

This will start the devbox environment and poetry environment and install all dependencies. And that is all you need to do to get started. (Yes, really.)

In a seperate terminal, run:

```bash
# Option 1
task docs

# Or if you prefer the docker version:
# Option 2
task docs-docker

# ONLY RUN ONE OF THE ABOVE
```

Docs are then available at: [http://127.0.0.1:8030/]()

All other commands are in the form of tasks. The project task file is `Taskfile.yaml`.

```bash
task --list-all # to see all project tasks
task <command> # usage
```

The project also uses gitflow for version control with gh-pages deployment automation. This is optional but you can also automate it using the `Taskfile.gitflow.yaml` file.

```bash
task -t Taskfile.gitflow.yaml --list-all # to see all gitflow tasks
task -t Taskfile.gitflow.yaml <command> # usage
```

See the [Tasks](../2-project/tasks/0-overview.md) section for more information on all tasks.

## Cleanup

To tear everything down after testing:

```bash
task cleanup-dev # to cleanup everything running locally
task cleanup-prod # to cleanup everything running in production (IF YOU USED ANY PROD. WORKFLOWS)
task cleanup-all # to cleanup everything (local and production)
```

## Need Help?

If you get stuck:

* Check the [Troubleshooting](../3-troubleshooting/0-overview.md) guide.
* Open an issue on [GitHub](https://github.com/sean-njela/demo_monitoring/issues)

Happy building!

---


