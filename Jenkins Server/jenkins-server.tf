// This Terraform Template creates a Jenkins Server using JDK 11 on an EC2 Instance.
// The Jenkins Server is enabled with Git, Docker, Docker Compose, AWS CLI Version 2,
// Python 3, Ansible, Terraform, and Boto3.
// The Jenkins Server will run on an Amazon Linux 2023 EC2 Instance with
// a custom security group allowing HTTP (80, 8080) and SSH (22) connections from anywhere.

provider "aws" {
  region = var.region
  // access_key and secret_key are optional if AWS credentials are already configured
  // in the AWS CLI or environment variables.
  // access_key = ""
  // secret_key = ""
}

resource "aws_instance" "tf-jenkins-server" {
  ami           = var.ami                  // Specify the AMI ID for Amazon Linux 2023
  instance_type = var.instance_type        // Specify the instance type (e.g., t2.micro)
  key_name      = var.mykey                // Specify the SSH key pair name
  vpc_security_group_ids = [aws_security_group.tf-jenkins-sec-gr.id] // Attach the security group
  iam_instance_profile = aws_iam_instance_profile.tf-jenkins-server-profile.name // Attach the IAM instance profile
  
  // Configure the root block device with 16GB of storage By configuring the root block device, you control the storage characteristics and behavior of the primary disk used by the EC2 instance.
  root_block_device {
    volume_size = 16
  }
  
  // Tag the instance with a name and purpose
  tags = {
    Name   = var.jenkins-server-tag
    server = "Jenkins"
  }
  
  // Provide user data script to configure Jenkins and other tools
  user_data = file("jenkinsdata.sh")
}

resource "aws_security_group" "tf-jenkins-sec-gr" {
  name = var.jenkins_server_secgr          // Specify the name for the security group
  tags = {
    Name = var.jenkins_server_secgr        // Tag the security group with a name
  }
  
  // Allow HTTP traffic on port 80 from any IP address
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  // Allow SSH traffic on port 22 from any IP address
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  // Allow HTTP traffic on port 8080 from any IP address
  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  // Allow all outbound traffic
  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "tf-jenkins-server-role" {
  name               = var.jenkins-role    // Specify the name for the IAM role
  
  // Define the assume role policy to allow EC2 instances to assume this role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

// Managed policies attached to the IAM role to provide necessary permissions
// - AmazonEC2ContainerRegistryFullAccess: Full access to Amazon ECR (Elastic Container Registry)
// - AWSCloudFormationFullAccess: Full access to AWS CloudFormation
// - AdministratorAccess: Full administrative access to all AWS resources
managed_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
  "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess",
  "arn:aws:iam::aws:policy/AdministratorAccess"
]
}
resource "aws_iam_instance_profile" "tf-jenkins-server-profile" {
  name = var.jenkins-profile              // Specify the name for the IAM instance profile
  role = aws_iam_role.tf-jenkins-server-role.name // Attach the IAM role created above
}

// Output the public DNS of the Jenkins server instance
output "JenkinsDNS" {
  value = aws_instance.tf-jenkins-server.public_dns
}

// Output the URL to access Jenkins, which includes the public DNS of the Jenkins server
output "JenkinsURL" {
  value = "http://${aws_instance.tf-jenkins-server.public_dns}:8080"
}
