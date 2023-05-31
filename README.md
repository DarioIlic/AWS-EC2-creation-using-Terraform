# AWS EC2 creation using Terraform and install WordPress
 Create AWS EC2 instance using Terraform and install WordPress

Requirements:
 - AWS account (free tier, you only need to have enough for verification that will be returned ~$1)
 - Install Terraform, depending on your OS, you can check it all here: https://developer.hashicorp.com/terraform/tutorials
 - Access key, best way is to create an IAM user, that is part of AWS account: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html (also good way to manage your AWS account) and put it in your config file for Terraform (that is not included here since this is a public repo after all)
 
All the rest is done in the configuration files:
 - Create an AWS Key Pair
 - Define AWS and Terraform Providers
 - Create a VPC, Subnet and other network components
 - Create OS Version Variables
 - Create a Security Group
 - Create the EC2 Instance (Virtual Machine)
 - Install Apache, PHP and MySQL
 - Download and extract WordPress
