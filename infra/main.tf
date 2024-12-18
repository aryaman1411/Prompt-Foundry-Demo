Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Here is a basic example of how you can use Terraform to create an Azure cloud infrastructure for an e-commerce web application. 

Please note that this is a very basic example and you may need to adjust it according to your specific needs. 

```hcl
provider "azurerm" {
  features {}
}

module "resource_group" {
  source  = "Azure/resource-group/azurerm"
  version = "2.0.0"

  name     = "example-resources"
  location = "West Europe"
}

module "network" {
  source              = "Azure/network/azurerm"
  version             = "3.0.0"
  resource_group_name = module.resource_group.name
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]
  depends_on          = [module.resource_group]
}

module "linux_servers" {
  source              = "Azure/compute/azurerm"
  version             = "1.0.0"
  resource_group_name = module.resource_group.name
  vm_size             = "Standard_B2s"
  public_ip           = "true"
  os_disk_type        = "Standard_LRS"
  network_security_group_rules = [
    {
      name                       = "SSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
  ]
  depends_on = [module.network]
}
```

This code creates a resource group, a virtual network with a single subnet, and a Linux server with a public IP address and an inbound rule allowing SSH access. 

Please replace the placeholders with your actual values. Also, remember to run `terraform init` to initialize your Terraform configuration before running `terraform apply` to create your infrastructure.

Remember, this is a basic example. Depending on your needs, you might want to add additional resources like databases, load balancers, DNS settings, etc. You might also want to consider using Azure Kubernetes Service (AKS) or Azure App Service if you're planning to use containers for your application.