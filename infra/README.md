# Terraform infra for AKS + ACR + Resource Group

This folder contains a minimal Terraform configuration to create:
- Azure Resource Group
- Azure Container Registry (ACR)
- Azure Kubernetes Service (AKS) cluster

Notes
- The Terraform configuration uses the azurerm provider and a local state by default. For production, configure a remote backend (Azure Storage) to store Terraform state safely.
- The AKS cluster is created with a system-assigned managed identity; the configuration attempts to assign the AcrPull role to the kubelet identity so AKS can pull images from the ACR.
- You must provide a valid SSH public key via the pipeline variable SSH_PUBLIC_KEY or in a tfvars file.

Required variables (set via pipeline variables or terraform.tfvars):
- prefix (default: "sample")
- location (default: "eastus")
- ssh_public_key (no default; please provide your SSH public key)

Basic usage (local)

cd infra
terraform init
terraform plan -out tfplan -var "ssh_public_key=<your-ssh-pubkey>"
terraform apply -auto-approve

Recommendations
- Configure a remote backend (azurerm) to store state. Example backend resource: Azure Storage account + container.
- Lock down RBAC and networking for production use.
- Pin Kubernetes version and node sizes according to your cluster requirements.
