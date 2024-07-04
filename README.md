React-Express-MongoDB + Infrastructure Deployment with Terraform, Packer, Ansible, and Kubernetes

This project automates the deployment of a scalable infrastructure on AWS using Terraform, Packer, Ansible, Docker, and Kubernetes (EKS). It includes setting up remote backend storage, database provisioning, continuous deployment for React applications, and securing deployments with GitHub Actions.

Infrastructure Overview
Terraform: Manages AWS resources including networking, EC2 instances, and EKS clusters.
Packer + Ansible: Automates the creation and configuration of EC2 instance images with a pre-configured database.
GitHub Actions: Automates deployment pipelines and ensures security through secrets management and deployment triggers.

Components and Deployment Steps

1. Remote Backend on S3 Bucket
Terraform is configured to use an S3 bucket as the remote backend to store state files securely.

2. Database Deployment
Using Packer and Ansible, we automate the creation and deployment of a database on an EC2 instance. This ensures consistent setup and configuration across environments.

3. Continuous Deployment for React Applications
React applications are built using GitHub Actions runners and deployed to a web S3 bucket. This enables automated updates and version control of the frontend.

4. Frontend Serving with CloudFront
CloudFront is used to serve the frontend, providing SSL setup and HTTPS redirections for secure and efficient content delivery.

5. Backend Deployment on EKS
The backend services are deployed on AWS EKS (Elastic Kubernetes Service) with a minimum of 3 replicas, ensuring high availability and scalability.

6. GitHub Branch Protection and Deployment Triggers
The main branch in GitHub is protected with mandatory code review approvals before merging. GitHub Actions are configured to manage all deployment processes securely, including handling sensitive information.

Getting Started

To deploy this infrastructure, follow these steps:

Clone Repository: git clone <repository-url>

Set Up AWS Credentials: Configure AWS CLI with credentials.

Deploy Infrastructure: Run Terraform scripts to provision resources.

Configure GitHub Actions: Set up secrets for AWS credentials and adjust deployment workflows as needed.

Repository Structure

/terraform: Contains Terraform scripts for AWS infrastructure.

/packer: Packer templates and Ansible playbooks for EC2 image creation.

.github/workflows: GitHub Actions workflows for CI/CD and deployment.
