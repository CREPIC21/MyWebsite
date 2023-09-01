## Azure Infrastructure Automation with Terraform

This project harnesses Terraform to automate the deployment of a comprehensive Azure infrastructure stack, enabling the streamlined provisioning of critical resources for hosting a web application on multiple Windows virtual machines (VMs). 

The core concept behind this project is to programmatically automate the provisioning of a web application on multiple Windows VMs using PowerShell scripts stored as blobs within a Storage Account. These scripts are executed on the VMs using virtual machine extensions. 

The "Application Gateway" plays a pivotal role in managing incoming traffic by redirecting it to specific Windows VMs based on the URL path, enhancing routing and load balancing capabilities.

The project encompasses the creation of the following Azure resources:
- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- Multiple Network Interfaces
- Multiple Windows VMs
- Storage Account
- Container and Blobs within the Storage Account
- VM Extension
- Application Gateway with all necessary configurations (Subnet, Public IP, Backend Address Pool, etc.)

### Getting Started
1. Clone this repository to your local machine:
```shell
git clone https://github.com/CREPIC21/MyWebsite
```
2. Change into the project directory:
```shell
cd MyWebsite/azure_terraform/05_AzureApplicationGateway_WindowsVM_Deployment/
```
3. Initialize your Terraform workspace:
```shell
terraform init
```
### Terraform Configuration
Ensure that you review and customize the Terraform configuration according to your specific requirements, such as resource names, region etc.

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