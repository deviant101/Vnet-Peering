# Azure VNet Peering Project

## Introduction

This project demonstrates the setup of VNet peering between two Azure Virtual Networks (VNets) using Terraform. VNet peering allows for seamless connectivity between VNets, enabling resources in either VNet to communicate with each other directly.

## Project Structure

The workspace contains several key files essential for the Terraform configuration:

- `main.tf`: Contains the core Terraform configuration for creating resource groups, VNets, subnets, and peering connections.
- `variables.tf`: Defines variables used in the Terraform configurations.
- `terraform.tfvars`: Specifies values for the defined variables.
- `provider.tf`: Configures the Azure provider for Terraform.
- `README.md`: Provides documentation on the project's purpose, architecture, and setup instructions.

## Terraform Configuration Overview

### Resource Group

A single resource group named `peering-rg` is created to contain all the resources for this project.

### Virtual Networks and Subnets

Two VNets are created in different Azure regions:

- **VNet-A** in the East US region with an address space of `10.5.0.0/16` and a default subnet of `10.5.0.0/24`.
- **VNet-B** in the Central US region with an address space of `10.15.0.0/16` and a default subnet of `10.15.0.0/24`.

### VNet Peering

Peering connections are established from VNet-A to VNet-B and vice versa. The configuration allows forwarded traffic but does not allow gateway transit.

## How to Use

1. Ensure you have Terraform and Azure CLI installed and configured.
2. Clone the repository containing the workspace.
3. Navigate to the project directory and initialize Terraform with `terraform init`.
4. Apply the Terraform configuration with `terraform apply`.

## Security Considerations

Discuss any Network Security Groups (NSGs) applied to the subnets or the VNets, including the allowed and denied traffic rules.

## Monitoring and Troubleshooting

- Utilize Azure Monitor to keep track of the network traffic.
- Use Azure Network Watcher for troubleshooting connectivity issues.

## Conclusion

This project sets up VNet peering within Azure using Terraform, ensuring seamless connectivity between different VNets while maintaining high security and performance standards.

## References

- [Azure Virtual Network Peering Overview](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)
- [Azure CLI for VNet Peering](https://docs.microsoft.com/en-us/cli/azure/network/vnet/peering?view=azure-cli-latest)
- [Azure PowerShell for VNet Peering](https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworkpeering?view=azps-6.1.0)