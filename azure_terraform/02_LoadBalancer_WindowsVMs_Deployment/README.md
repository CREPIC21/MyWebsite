## Azure Infrastructure Provisioning with Terraform

This project utilizes Terraform to automate the deployment of a comprehensive Azure infrastructure stack, facilitating the provisioning of various essential resources for hosting a web application on multiple Windows virtual machines (VMs) placed behind the "Load Balancer" which plays a crucial role in ensuring high availability and distributing incoming traffic evenly across the Windows VMs, enhancing the application's scalability and fault tolerance. 

The "Availability Set" resource is important for ensuring high availability and reliability of the web application. By distributing Windows VMs across fault domains within an Availability Set, the project ensures that if a physical server or underlying hardware fails, only a portion of the VMs is affected, and the application remains available. This enhances the overall resilience and fault tolerance of the deployed infrastructure.
The project's key components include:
- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- Multiple Network Interfaces
- Multiple Windows VMs
- Availability Set (ensuring high availability by distributing VMs across fault domains)
- Storage Account
- Container and Blobs within the Storage Account
- VM Extension
- Load Balancer with all necessary configurations (Public IP, Backend Address Pool, Probes, Rules)
- DNS Zone and DNS Records

### Getting Started
1. Clone this repository to your local machine:
```shell
git clone https://github.com/CREPIC21/MyWebsite
```
2. Change into the project directory:
```shell
cd MyWebsite/azure_terraform/02_LoadBalancer_WindowsVMs_Deployment/
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
- you will be prompted to confirm the deployment, type `yes` to proceed and Terraform will provision the specified Azure resources

### Clean Up
To avoid incurring unnecessary charges, it's essential to clean up the Azure resources when you're done with them. Run the following command to destroy the resources created by Terraform:
```shell
terraform destroy
```
- you will be prompted to confirm the deployment, type `yes` to proceed