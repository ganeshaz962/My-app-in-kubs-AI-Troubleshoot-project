# Sample microservices for AKS

This repository contains two minimal Node.js microservices (service-a and service-b), Kubernetes manifests for deployment to AKS, and an Azure DevOps pipeline to build Docker images, push them to Azure Container Registry (ACR), and deploy to AKS.

Quick overview

- service-a: simple Express app on port 3000
- service-b: simple Express app on port 3000
- k8s/: Kubernetes manifests (namespace, deployments and services)
- azure-pipelines.yml: Azure DevOps pipeline

What you must configure in Azure DevOps

1. Create an Azure Resource Manager service connection (name used in pipeline variable AZURE_SUBSCRIPTION)
2. Create an ACR service connection (type: Azure Container Registry or Docker Registry) and set ACR_SERVICE_CONNECTION variable to its name
3. Set ACR_LOGIN_SERVER to your registry's login server (e.g. myregistry.azurecr.io)
4. Set AKS_RESOURCE_GROUP and AKS_CLUSTER_NAME to your AKS values

Pipeline behavior

- Build stage: builds and pushes two images to ACR with tag $(Build.BuildId)
  - repository names used: service-a and service-b (pushed to <ACR_LOGIN_SERVER>/service-a:TAG)
- Deploy stage: uses AzureCLI to fetch AKS credentials and kubectl to apply manifests. The deployment manifest placeholders are replaced with the real image names.

How to run locally

- Build images locally:
  docker build -t myregistry.azurecr.io/service-a:local -f service-a/Dockerfile ./service-a
  docker build -t myregistry.azurecr.io/service-b:local -f service-b/Dockerfile ./service-b

- Push to ACR (after docker login):
  docker push myregistry.azurecr.io/service-a:local
  docker push myregistry.azurecr.io/service-b:local

- Deploy to cluster (after configuring kubectl context):
  sed "s|REPLACE_WITH_IMAGE_SERVICE_A|myregistry.azurecr.io/service-a:local|g" k8s/service-a-deployment.yaml > k8s/service-a-deployment.tmp.yaml
  sed "s|REPLACE_WITH_IMAGE_SERVICE_B|myregistry.azurecr.io/service-b:local|g" k8s/service-b-deployment.yaml > k8s/service-b-deployment.tmp.yaml
  kubectl apply -f k8s/namespace.yaml
  kubectl apply -f k8s/service-a-deployment.tmp.yaml
  kubectl apply -f k8s/service-a-service.yaml
  kubectl apply -f k8s/service-b-deployment.tmp.yaml
  kubectl apply -f k8s/service-b-service.yaml

Notes

- This is a minimal example to get you started. For production, consider:
  - Using imagePullSecrets if your cluster needs them for ACR
  - Using Kubernetes Ingress or an external LoadBalancer for external traffic
  - Adding health/readiness probes, resource requests/limits, and liveness checks
  - Replacing placeholder variables with templating (Helm, Kustomize, or GitOps)
