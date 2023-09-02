## Azure Infrastructure Automation with Terraform

This project leverages Terraform to automate the deployment of a robust Azure infrastructure stack, enabling the seamless provisioning of critical resources for hosting a web application on a Windows virtual machine (VM) which is provisioned behind firewall. 

The primary objective of this project is to programmatically automate the provisioning of a web application on a Windows VM using PowerShell scripts stored as blobs within a Storage Account. These scripts are executed on the VMs using virtual machine extensions. 

The "Firewall" plays a pivotal role in managing incoming and outgoing traffic, enforcing security and access control policies. It also provides a public IP address for accessing the web application and controls RDP connections to the VM.

The project encompasses the creation of the following Azure resources:
- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- Network Interface
- Windows VM
- Storage Account
- Container and Blobs within the Storage Account
- VM Extension
- Firewall with all necessary configurations (Subnet, Public IP, Policy, and Rule Collection Group)

### Getting Started
1. Clone this repository to your local machine:
```shell
git clone https://github.com/CREPIC21/MyWebsite
```
2. Change into the project directory:
```shell
cd MyWebsite/azure_terraform/04_AzureFirewall_WindowsVM_Deployment/
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
- you will be prompted to confirm the deployment, type `yes` to proceed and Terraform will provision the specified Azure resources

### Clean Up
To avoid incurring unnecessary charges, it's essential to clean up the Azure resources when you're done with them. Run the following command to destroy the resources created by Terraform:
```shell
terraform destroy
```
- you will be prompted to confirm the deployment, type `yes` to proceed