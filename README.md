# devops-workflow
Repo for demonstrating a typical "devops" workflow. A typical "devops" workflow consists of build -> test -> validate -> release cycle. 

This repo aims to show a typical build -> test -> validate -> release cycle can be created and applied. This repo consists of a simple Flask Hello World application and a simple test for it. The supporting toolchain around this includes:

- Packer, for building a custom AMI based on an existing base (in this case, a stock Ubuntu 18.04 image)
- Ansible, for config management and provisioning the necessary tools
- Terraform for building the necessary resources and instances on AWS.
- A Jenkinsfile which defines a Jenkins pipeline script for each of the different stages.

Things that are included in the repo but not yet integrated in the cycle:

- A Dockerfile for building a Docker image
- Necessary integrations and plugins required for auto deploy on a github commit/push

### Jenkins plugins

Following Jenkins plugins were used to achieve the desired result:

- AnsiColor (for coloring console output)
- Github Integration
- Pipeline AWS steps (to inject AWS credentials, but can be used for many other things)
