// Specify the name of your SSH key pair that will be used to access the EC2 instance
mykey = "your_key_name"

// Specify the Amazon Machine Image (AMI) ID for Amazon Linux 2023
// AMI IDs are region-specific, so ensure this ID matches your chosen region
ami = "ami-08a0d1e16fc3f61ea"

// Specify the AWS region where the Jenkins server will be deployed
// Example: us-east-1, us-west-2, etc.
region = "us-east-1"

// Specify the EC2 instance type for the Jenkins server
// Example: t2.micro for low-cost, t3a.medium for more performance
instance_type = "t3a.medium"

// Specify the name for the security group associated with the Jenkins server
// This security group will define the inbound and outbound rules for network traffic
jenkins_server_secgr = "your-jenkins-server-secgr"

// Specify the tag to be applied to the Jenkins server instance
// Tags help in identifying and managing AWS resources
jenkins-server-tag = "Jenkins Server"

// Specify the name for the IAM instance profile to be attached to the Jenkins server
// The instance profile allows the EC2 instance to assume an IAM role with specific permissions
jenkins-profile = "your-jenkins-profile-tr"

// Specify the name of the IAM role that will be assigned to the Jenkins server
// This role will grant the necessary permissions for the Jenkins server to interact with other AWS services
jenkins-role = "your-jenkins-server-role"


//jenkins_variable.tf is for defining what variables are needed.
// jenkins.auto.tfvars is for providing the values for those variables.
// Both files are essential, but jenkins.auto.tfvars will be the one setting the actual values that Terraform uses during execution.
