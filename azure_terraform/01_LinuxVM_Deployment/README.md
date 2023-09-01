## Azure Infrastructure Provisioning with Terraform

This project leverages Terraform to automate the provisioning of essential Azure resources and deploy a Linux virtual machine (VM) hosting a web application. 

Additionally, it establishes a secure connection to the Linux VM using public and private keys. Once the infrastructure is provisioned, a web application is deployed to the Linux VM via a shell script executed with the `custom_data` property of Linux VM resource.

Project streamlines the creation of the following Azure resources:
- Resource Group
- Virtual Network
- Network Security Group
- Network Interface
- Public IP Address
- Linux Virtual Machine

### Getting Started
1. Clone this repository to your local machine:
```shell
git clone https://github.com/CREPIC21/MyWebsite
```
2. Change into the project directory:
```shell
cd MyWebsite/azure_terraform/01_LinuxVM_Deployment/
```
3. Initialize your Terraform workspace:
```shell
terraform init
```
### Terraform Configuration
Ensure that you review and customize the Terraform configuration according to your specific requirements, such as resource names, region, VM specifications etc.

### Deployment
1. Deploy the Azure resources by running:
```shell
terraform apply
```
- you will be prompted to confirm the deployment, type `yes` to proceed

2. Terraform will provision the specified Azure resources, including the Linux VM. Once the deployment is complete, it will execute the `custom_data` script to deploy the web application.

### Clean Up
To avoid incurring unnecessary charges, it's essential to clean up the Azure resources when you're done with them. Run the following command to destroy the resources created by Terraform:
```shell
terraform destroy
```
- you will be prompted to confirm the deployment, type `yes` to proceed