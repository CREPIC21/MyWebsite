## ## Azure Infrastructure Automation with Terraform

This project harnesses Terraform to streamline the provisioning of essential Azure resources, enabling the automated deployment of a web application on Azure Web App services.

The core concept behind this project is to programmatically automate the provisioning of a web application on Azure Web App using a Docker image. The Azure Web App is configured with different slots - one for staging and one for production. This design allows for a clear separation of environments, with one slot serving as a testing and development environment and the other dedicated to production.

The project encompasses the creation of the following Azure resources:
- Resource Group
- Service Plan
- Linux Web App
- Web App Slot (for staging)
- Web App Active Slot (for production)

### Getting Started
1. Clone this repository to your local machine:
```shell
git clone https://github.com/CREPIC21/MyWebsite
```
2. Change into the project directory:
```shell
cd MyWebsite/azure_terraform/03_WebApp_Deployment/
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