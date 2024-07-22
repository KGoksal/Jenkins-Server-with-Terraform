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
4. Access Jenkins: Once deployed, Jenkins can be accessed at the following URL: _public-dns-of-jenkins-server:8080_


**Resources Created**

- AWS EC2 instance running Amazon Linux 2023 with JDK 11 and specified tools.
- Custom IAM role and instance profile for Jenkins server access.
- Security group allowing HTTP (80), SSH (22), and Jenkins web UI (8080) access from anywhere.

**Variables**
- region: AWS region to deploy the resources.
- ami: Amazon Machine Image ID for Amazon Linux 2023.
- instance_type: EC2 instance type for the Jenkins server.
- mykey: Name of the SSH key pair used to access the instance.
- jenkins-server-tag: Tag applied to the Jenkins EC2 instance.
- jenkins_server_secgr: Name for the Jenkins server's security group.
- jenkins-role: Name for the IAM role used by the Jenkins server.
- jenkins-profile: Name for the IAM instance profile used by the Jenkins server.

**Outputs**
- JenkinsDNS: Public DNS of the Jenkins server instance.
- JenkinsURL: URL to access Jenkins web UI.
- For more information on Terraform, refer to the Terraform Documentation.
