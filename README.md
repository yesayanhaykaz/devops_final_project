
#React-Express-MongoDB Deployment


***Welcome to the DevOps project README. This document provides an overview of the project and detailed instructions for setting up and deploying the infrastructure and applications.
***

###Project Overview

This project aims to deploy a scalable web application infrastructure on AWS using Terraform, Packer, Ansible, GitHub Actions, CloudFront, and Amazon EKS. Below are the main tasks and their respective setups:

##Tasks
** 1. Database Creation with Packer + Ansible and Deployment on EC2 **
Description: Create a database using Packer and Ansible and deploy it on EC2 instances.
**2. Remote Backend on S3 Bucket
**Description: Configure Terraform to use S3 as a remote backend for state storage.
**3. Infrastructure Creation with Terraform on AWS
**Description: Use Terraform to provision infrastructure on AWS.
**4. Building React Files with GitHub Actions and Uploading to S3 Bucket
**Description: Automate the build process of React files using GitHub Actions and deploy to an S3 bucket.
**5. Frontend Serving with CloudFront, SSL Setup, and HTTPS Redirections
**Description: Serve the frontend application using CloudFront with SSL setup and HTTPS redirections.
**6. Backend Deployment on EKS with Minimum 3 Replicas
**Description: Deploy the backend application on Amazon EKS with a minimum of 3 replicas for scalability and high availability.

##Setup Instructions
Prerequisites
**Ensure you have the following installed and configured:
**
AWS CLI
Terraform
Packer
Ansible

###GitHub Actions setup with appropriate secrets and workflows
Steps

Automating PostgreSQL AMI Creation with Packer, Ansible, and GitHub Actions
Overview: This guide shows you how to automate creating an AWS AMI with PostgreSQL using Packer, Ansible, and GitHub Actions.

Create the Packer Template
Make a Packer template to set up the AMI build process. This template specifies the base AMI, instance type, region, and the Ansible playbook for provisioning.
Create the Ansible Playbook

Write an Ansible playbook to install and set up PostgreSQL on the instance. The playbook handles installing PostgreSQL, starting the service, and creating a PostgreSQL user and database.
Set Up GitHub Actions Workflow

**Set up a GitHub Actions workflow to automate the AMI creation. The workflow includes steps to:
**Check out the repository
Set up Python and Ansible
Install Packer and AWS CLI
Configure AWS credentials
Build the AMI
Capture and output the AMI ID
Add Secrets to GitHub

**Securely store your AWS credentials in GitHub Secrets. This allows the workflow to access the needed credentials to build the AMI.
**

###Using the AMI with Terraform

After the AMI is created, use the AMI ID in your Terraform configuration to launch an EC2 instance. This allows you to deploy infrastructure using the newly created AMI.
Conclusion: Following these steps, you can automate the creation of an AWS AMI with PostgreSQL using Packer, Ansible, and GitHub Actions. This makes it easier to manage and deploy your infrastructure.

Remote Backend on S3 Bucket
Create an S3 bucket manually.
Update backend.tf to configure Terraform to use the S3 bucket as the backend.
Infrastructure Setup with Terraform
This guide outlines the setup of a complete infrastructure on AWS using Terraform. The infrastructure includes a VPC, an EC2 instance with a PostgreSQL image created using Packer and Ansible, an EKS cluster for the backend, a load balancer, S3 for the frontend, and CloudFront for serving the frontend.

Set Up a VPC

Create a Virtual Private Cloud (VPC) to isolate your resources. Configure subnets, route tables, and internet gateways to allow communication within the VPC and to the internet.
Launch an EC2 Instance

Use the AMI created by Packer and Ansible to launch an EC2 instance. This instance will have PostgreSQL installed and configured, ready for your applications to use.
Set Up an EKS Cluster

Create an Amazon Elastic Kubernetes Service (EKS) cluster to manage your backend services. This cluster will run your applications in a highly available and scalable environment.
Configure a Load Balancer

Set up a load balancer using Terraform to distribute traffic to your backend services running in the EKS cluster. This ensures that your applications can handle varying loads and remain accessible.
Set Up S3 for Frontend

Create an S3 bucket using Terraform to store your frontend files. These files can be static assets like HTML, CSS, and JavaScript, which will be served to users. Automate this setup with GitHub Actions.
Configure CloudFront

Use CloudFront to serve your frontend files from S3. CloudFront will cache your files at edge locations worldwide, providing faster access to users and reducing load on your S3 bucket. Automate this configuration with GitHub Actions.
Create a GitHub Actions Workflow

Create a new YAML file (e.g., .github/workflows/deploy-infrastructure.yml) in your repository under the .github/workflows/ directory. This file will define the GitHub Actions workflow for deploying your Terraform infrastructure.

Building React Files with GitHub Actions and Uploading to S3 Bucket

Configure GitHub Actions workflows in .github/workflows/ to build React files.

Ensure the workflow uploads the built files to the designated S3 bucket.

Frontend Serving with CloudFront, SSL Setup, and HTTPS Redirections

Create a CloudFront distribution with the S3 bucket as the origin.

Obtain or import an SSL certificate from AWS ACM.

Configure CloudFront to use HTTPS and set up HTTP to HTTPS redirections.

Backend Deployment on EKS with Minimum 3 Replicas

Define Kubernetes manifests (deployment.yaml, service.yaml) for the backend application.

Create a new YAML file (e.g., .github/workflows/deploy-backend-eks.yml) in your repository under the .github/workflows/ directory. This file will define the GitHub Actions workflow for deploying your backend application on EKS with a minimum of 3 replicas.

##Project Requirements

Create Infrastructure with Terraform on AWS
Remote Backend on S3 Bucket
Database Creation with Packer + Ansible and Deployment on EC2 Instance
Build React Files on GitHub Actions and Upload to S3 Bucket
Frontend Served by CloudFront with SSL Setup and HTTPS Redirections
Backend Deployment on EKS with Minimum 3 Replicas
GitHub Main Branch Protection with at Least 1 Reviewer Approval
GitHub Actions Should Contain All Secrets and Trigger for All Deployments
