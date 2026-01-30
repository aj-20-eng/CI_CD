📘 AI Application Deployment on AKS using GitHub CI/CD, Docker & ACR
📌 Overview

This project demonstrates an end-to-end Platform Engineering workflow where:

Azure Kubernetes Service (AKS) is provisioned using GitHub Actions + Bicep (IaC)

Azure Container Registry (ACR) is created to store container images

AI application is built locally using Docker

Docker image is pushed to ACR

AKS is attached to ACR using Managed Identity

Application is deployed using Kubernetes Deployment Manifest

Future enhancement: Helm + CI/CD automation

🏗 Architecture Flow
Developer Laptop → Docker Build → Azure Container Registry (ACR)  
→ AKS pulls image via Managed Identity → Kubernetes Deployment  
→ Azure Load Balancer Public Endpoint

🚀 Step 1: Verify Azure Login & Subscription
az account show


Purpose: Confirms Azure tenant and subscription context.

🚀 Step 2: List AKS Clusters
az aks list -o table


Purpose: Verifies that AKS cluster created via GitHub Actions exists.

🚀 Step 3: Create Azure Container Registry (ACR)
az acr create --resource-group rg-aks-demo --name myplatformacr123 --sku Basic --location eastus


Purpose: Creates Azure Container Registry to store Docker images.

🚀 Step 4: Login to Azure Container Registry
az acr login --name myplatformacr123


Purpose: Authenticates Docker client with ACR using Azure AD (no credentials stored).

🚀 Step 5: Tag Local Docker Image

Local image name: ai-chat-ui:v1

docker tag ai-chat-ui:v1 myplatformacr123.azurecr.io/ai-chat-ui:v1


Purpose: Tags the local Docker image with ACR registry path.

🚀 Step 6: Push Docker Image to ACR
docker push myplatformacr123.azurecr.io/ai-chat-ui:v1


Purpose: Uploads the AI application container image to ACR.

🚀 Step 7: Verify Image in ACR
az acr repository list --name myplatformacr123 -o table


Purpose: Confirms the image repository exists in ACR.

🚀 Step 8: Attach ACR to AKS (Managed Identity)
az aks update --resource-group rg-aks-demo --name demo-aks-poc1 --attach-acr myplatformacr123


Purpose: Grants AKS permission to pull images securely from ACR without Kubernetes secrets (enterprise best practice).

🚀 Step 9: Update Kubernetes Deployment Manifest

Update image reference in ui-deployment.yml:

image: myplatformacr123.azurecr.io/ai-chat-ui:v1

🚀 Step 10: Deploy Application to AKS
kubectl apply -f ui-deployment.yml

🚀 Step 11: Expose Application via LoadBalancer
kubectl expose deployment ai-chat-ui --type=LoadBalancer --port=80

🚀 Step 12: Get Public Endpoint
kubectl get svc


Open in browser:

http://<EXTERNAL-IP>

📊 Platform Engineering Highlights

Infrastructure provisioned using GitHub Actions + Bicep (IaC)

Secure container registry using Azure Container Registry

Docker-based AI application containerization

AKS integrated with ACR using Managed Identity (no secrets)

Kubernetes deployment using YAML manifests

Public exposure using Azure Load Balancer

🔮 Future Enhancements

Helm charts for Kubernetes deployments

GitHub Actions CI/CD pipeline for Docker build → ACR push → AKS deploy

Blue/Green or Canary deployments

Auto-scaling using HPA

Monitoring using Azure Monitor / Prometheus

GitOps with ArgoCD

🎯 Enterprise CI/CD Vision
Developer Commit → GitHub Actions → Docker Build  
→ Push Image to ACR → Helm Deploy to AKS  
→ Automated Testing → Production Release

🧠 Key Learnings

Platform Engineering enables self-service infrastructure

Containers standardize application packaging

Kubernetes provides scalable orchestration

CI/CD automates delivery pipelines

Managed Identity improves security posture

👨‍💻 Author

Amit kr
Platform Engineering & Cloud Architecture Demo
