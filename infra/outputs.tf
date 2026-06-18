output "resource_group_name" {
  description = "The resource group created for the infra"
  value       = azurerm_resource_group.rg.name
}

output "acr_login_server" {
  description = "Login server for the created ACR"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_name" {
  description = "ACR name"
  value       = azurerm_container_registry.acr.name
}

output "aks_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "kube_admin_config_raw" {
  description = "Raw kubeconfig for cluster admin (sensitive)"
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive   = true
}
