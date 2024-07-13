<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevOps Project README</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h1, h2, h3, h4 {
            color: #333;
        }
        ul {
            list-style-type: disc;
            margin-left: 20px;
        }
        code {
            background-color: #eaeaea;
            padding: 2px 4px;
            border-radius: 3px;
        }
    </style>
</head>
<body>
    <h1>React-Express-MongoDB Deployment</h1>

    <p>Welcome to the DevOps project README. This document provides an overview of the project and detailed instructions for setting up and deploying the infrastructure and applications.</p>

    <h2>Project Overview</h2>

    <p>This project aims to deploy a scalable web application infrastructure on AWS using Terraform, Packer, Ansible, GitHub Actions, CloudFront, and Amazon EKS. Below are the main tasks and their respective setups:</p>

    <h2>Tasks</h2>

    <h3>1. Database Creation with Packer + Ansible and Deployment on EC2</h3>
    <p><strong>Description:</strong> Create a database using Packer and Ansible and deploy it on EC2 instances.</p>

    <h3>2. Remote Backend on S3 Bucket</h3>
    <p><strong>Description:</strong> Configure Terraform to use S3 as a remote backend for state storage.</p>

    <h3>3. Infrastructure Creation with Terraform on AWS</h3>
    <p><strong>Description:</strong> Use Terraform to provision infrastructure on AWS.</p>

    <h3>4. Building React Files with GitHub Actions and Uploading to S3 Bucket</h3>
    <p><strong>Description:</strong> Automate the build process of React files using GitHub Actions and deploy to an S3 bucket.</p>

    <h3>5. Frontend Serving with CloudFront, SSL Setup, and HTTPS Redirections</h3>
    <p><strong>Description:</strong> Serve the frontend application using CloudFront with SSL setup and HTTPS redirections.</p>

    <h3>6. Backend Deployment on EKS with Minimum 3 Replicas</h3>
    <p><strong>Description:</strong> Deploy the backend application on Amazon EKS with a minimum of 3 replicas for scalability and high availability.</p>

    <h2>Setup Instructions</h2>

    <h3>Prerequisites</h3>
    <p>Ensure you have the following installed and configured:</p>
    <ul>
        <li>AWS CLI</li>
        <li>Terraform</li>
        <li>Packer</li>
        <li>Ansible</li>
        <li>GitHub Actions setup with appropriate secrets and workflows</li>
    </ul>

    <h3>Steps</h3>

    <h4>Automating PostgreSQL AMI Creation with Packer, Ansible, and GitHub Actions</h4>

    <p><strong>Overview:</strong> This guide shows you how to automate creating an AWS AMI with PostgreSQL using Packer, Ansible, and GitHub Actions.</p>

    <h4>Create the Packer Template</h4>
    <p>Make a Packer template to set up the AMI build process. This template specifies the base AMI, instance type, region, and the Ansible playbook for provisioning.</p>

    <h4>Create the Ansible Playbook</h4>
    <p>Write an Ansible playbook to install and set up PostgreSQL on the instance. The playbook handles installing PostgreSQL, starting the service, and creating a PostgreSQL user and database.</p>

    <h4>Set Up GitHub Actions Workflow</h4>
    <p>Set up a GitHub Actions workflow to automate the AMI creation. The workflow includes steps to:</p>
    <ul>
        <li>Check out the repository</li>
        <li>Set up Python and Ansible</li>
        <li>Install Packer and AWS CLI</li>
        <li>Configure AWS credentials</li>
        <li>Build the AMI</li>
        <li>Capture and output the AMI ID</li>
    </ul>

    <h4>Add Secrets to GitHub</h4>
    <p>Securely store your AWS credentials in GitHub Secrets. This allows the workflow to access the needed credentials to build the AMI.</p>

    <h4>Using the AMI with Terraform</h4>
    <p>After the AMI is created, use the AMI ID in your Terraform configuration to launch an EC2 instance. This allows you to deploy infrastructure using the newly created AMI.</p>

    <p><strong>Conclusion:</strong> Following these steps, you can automate the creation of an AWS AMI with PostgreSQL using Packer, Ansible, and GitHub Actions. This makes it easier to manage and deploy your infrastructure.</p>

    <h4>Remote Backend on S3 Bucket</h4>
    <ul>
        <li>Create an S3 bucket manually.</li>
        <li>Update <code>backend.tf</code> to configure Terraform to use the S3 bucket as the backend.</li>
    </ul>

    <h4>Infrastructure Setup with Terraform</h4>

    <p>This guide outlines the setup of a complete infrastructure on AWS using Terraform. The infrastructure includes a VPC, an EC2 instance with a PostgreSQL image created using Packer and Ansible, an EKS cluster for the backend, a load balancer, S3 for the frontend, and CloudFront for serving the frontend.</p>

    <h4>Set Up a VPC</h4>
    <p>Create a Virtual Private Cloud (VPC) to isolate your resources. Configure subnets, route tables, and internet gateways to allow communication within the VPC and to the internet.</p>

    <h4>Launch an EC2 Instance</h4>
    <p>Use the AMI created by Packer and Ansible to launch an EC2 instance. This instance will have PostgreSQL installed and configured, ready for your applications to use.</p>

    <h4>Set Up an EKS Cluster</h4>
    <p>Create an Amazon Elastic Kubernetes Service (EKS) cluster to manage your backend services. This cluster will run your applications in a highly available and scalable environment.</p>

    <h4>Configure a Load Balancer</h4>
    <p>Set up a load balancer using Terraform to distribute traffic to your backend services running in the EKS cluster. This ensures that your applications can handle varying loads and remain accessible.</p>

    <h4>Set Up S3 for Frontend</h4>
    <p>Create an S3 bucket using Terraform to store your frontend files. These files can be static assets like HTML, CSS, and JavaScript, which will be served to users. Automate this setup with GitHub Actions.</p>

    <h4>Configure CloudFront</h4>
    <p>Use CloudFront to serve your frontend files from S3. CloudFront will cache your files at edge locations worldwide, providing faster access to users and reducing load on your S3 bucket. Automate this configuration with GitHub Actions.</p>

    <h4>Create a GitHub Actions Workflow</h4>
    <p>Create a new YAML file (e.g., <code>.github/workflows/deploy-infrastructure.yml</code>) in your repository under the <code>.github/workflows/</code> directory. This file will define the GitHub Actions workflow for deploying your Terraform infrastructure.</p>

    <h4>Building React Files with GitHub Actions and Uploading to S3 Bucket</h4>
    <ul>
        <li>Configure GitHub Actions workflows in <code>.github/workflows/</code> to build React files.</li>
        <li>Ensure the workflow uploads the built files to the designated S3 bucket.</li>
    </ul>

    <h4>Frontend Serving with CloudFront, SSL Setup, and HTTPS Redirections</h4>
    <ul>
        <li>Create a CloudFront distribution with the S3 bucket as the origin.</li>
        <li>Obtain or import an SSL certificate from AWS ACM.</li>
        <li>Configure CloudFront to use HTTPS and set up HTTP to HTTPS redirections.</li>
    </ul>

    <h4>Backend Deployment on EKS with Minimum 3 Replicas</h4>
    <ul>
        <li>Define Kubernetes manifests (<code>deployment.yaml</code>, <code>service.yaml</code>) for the backend application.</li>
        <li>Create a new YAML file (e.g., <code>.github/workflows/deploy-backend-eks.yml</code>) in your repository under the <code>.github/workflows/</code> directory. This file will define the GitHub Actions workflow for deploying your backend application on EKS with a minimum of 3 replicas.</li>
    </ul>

    <h2>Project Requirements</h2>
    <ul>
        <li>Create Infrastructure with Terraform on AWS</li>
        <li>Remote Backend on S3 Bucket</li>
        <li>Database Creation with Packer + Ansible and Deployment on EC2 Instance</li>
        <li>Build React Files on GitHub Actions and Upload to S3 Bucket</li>
        <li>Frontend Served by CloudFront with SSL Setup and HTTPS Redirections</li>
        <li>Backend Deployment on EKS with Minimum 3 Replicas</li>
        <li>GitHub Main Branch Protection with at Least 1 Reviewer Approval</li>
        <li>GitHub Actions Should Contain All Secrets and Trigger for All Deployments</li>
    </ul>
</body>
</html>
