# Terraform Template: Jenkins Server on AWS EC2

This Terraform template deploys a Jenkins Server on an Amazon EC2 instance running Amazon Linux 2023. The Jenkins server is configured with JDK 11 and includes the following tools:

- Git
- Docker and Docker Compose
- AWS CLI Version 2
- Python 3
- Ansible
- Terraform
- Boto3

## Prerequisites

Before you begin, ensure you have:

- AWS credentials configured locally or in your environment.
- Terraform installed on your local machine.

## Usage

1. Clone this repository
2. Initialize Terraform: **terraform init**
3. Deploy the Jenkins Server: **terraform apply**
4. Access Jenkins: Once deployed, Jenkins can be accessed at the following URL: _<public-dns-of-jenkins-server>:8080_
