provider "azurerm" {
  features = {}
}

variable "prefix" {
  description = "Prefix used for resource names"
  type        = string
  default     = "sample"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "${var.prefix}-rg"
}

variable "acr_name" {
  description = "ACR name (must be globally unique, lowercase, 5-50 chars)"
  type        = string
  default     = "${var.prefix}acr"
}

variable "acr_sku" {
  description = "ACR sku"
  type        = string
  default     = "Standard"
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
  default     = "${var.prefix}-aks"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for AKS (empty = provider default)"
  type        = string
  default     = ""
}

variable "node_count" {
  description = "Initial node count for the AKS node pool"
  type        = number
  default     = 1
}

variable "node_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "ssh_public_key" {
  description = "SSH public key for the AKS nodes (required)"
  type        = string
  default     = ""
}
