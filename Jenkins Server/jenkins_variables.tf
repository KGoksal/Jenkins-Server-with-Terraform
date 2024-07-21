// Define the name of the SSH key pair used to access the EC2 instance
variable "mykey" {}

// Define the Amazon Machine Image (AMI) ID for Amazon Linux 2023
variable "ami" {
  description = "amazon linux 2023 ami"
}

// Define the AWS region where the resources will be deployed
variable "region" {}

// Define the type of EC2 instance to launch (e.g., t2.micro)
variable "instance_type" {}

// Define the name for the security group associated with the Jenkins server
variable "jenkins_server_secgr" {}

// Define the tag for naming the Jenkins server instance
variable "jenkins-server-tag" {}

// Define the name for the IAM instance profile for the Jenkins server
variable "jenkins-profile" {}

// Define the name for the IAM role assigned to the Jenkins server
variable "jenkins-role" {}


// {} means they are placeholder variables that do not have default values and must be provided by the user or through a Terraform variables file (.tfvars) or via the command line
