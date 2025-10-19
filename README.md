
# Wisecow Kubernetes Deployment

Fortune-telling web application deployed on Kubernetes with automated CI/CD pipeline and TLS encryption.

## Project Overview

**Wisecow** displays random fortune quotes with ASCII cow art. This project demonstrates:
- Docker containerization
- Kubernetes deployment
- GitHub Actions CI/CD
- TLS/HTTPS security

## Architecture

- **Application**: Bash script using fortune-mod and cowsay
- **Container**: Docker image based on Ubuntu 22.04
- **Orchestration**: Kubernetes with 2 replicas for high availability
- **Access**: NGINX Ingress with TLS termination
- **CI/CD**: GitHub Actions for automated builds

## Prerequisites

- Ubuntu 20.04+ or similar Linux distribution
- Docker Engine
- Kubernetes cluster (Minikube/Kind for local)
- kubectl CLI
- Docker Hub account
- GitHub account

## Quick Start

### 1. Clone Repository
\`\`\`bash
git clone https://github.com/YOUR-USERNAME/wisecow-deployment.git
cd wisecow-deployment
\`\`\`

### 2. Start Minikube
\`\`\`bash
minikube start --driver=docker
minikube addons enable ingress
\`\`\`

### 3. Create TLS Secret
\`\`\`bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt \
  -subj "/CN=wisecow.local/O=wisecow"

kubectl create secret tls wisecow-tls-secret \
  --cert=tls.crt --key=tls.key
\`\`\`

### 4. Deploy Application
\`\`\`bash
kubectl apply -f k8s/
\`\`\`

### 5. Configure Local DNS
\`\`\`bash
echo "$(minikube ip)  wisecow.local" | sudo tee -a /etc/hosts
\`\`\`

### 6. Access Application
- HTTP: \`minikube service wisecow-service --url\`
- HTTPS: \`https://wisecow.local\`

## Files Structure

\`\`\`
.
├── Dockerfile                 # Container image definition
├── .dockerignore             # Files to exclude from image
├── wisecow.sh                # Application script
├── k8s/
│   ├── deployment.yaml       # Kubernetes deployment (2 replicas)
│   ├── service.yaml          # NodePort service
│   └── ingress.yaml          # NGINX ingress with TLS
└── .github/
    └── workflows/
        └── ci-cd.yaml        # GitHub Actions workflow
\`\`\`

## CI/CD Pipeline

GitHub Actions automatically:
1. Triggers on push to main branch
2. Builds Docker image
3. Tags with latest, branch name, and commit SHA
4. Pushes to Docker Hub

## Security Features

- TLS/HTTPS encryption
- Docker Hub credentials stored as GitHub secrets
- Self-signed certificate (use cert-manager for production)
- Resource limits prevent resource exhaustion

## Troubleshooting

**Pods not starting**:
\`\`\`bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
\`\`\`

**Ingress not working**:
\`\`\`bash
kubectl get ingress
kubectl describe ingress wisecow-ingress
\`\`\`

**Check service**:
\`\`\`bash
kubectl get svc wisecow-service
minikube service wisecow-service --url
\`\`\`

## Scaling

Scale replicas:
\`\`\`bash
kubectl scale deployment wisecow-deployment --replicas=5
\`\`\`

## Cleanup

\`\`\`bash
kubectl delete -f k8s/
kubectl delete secret wisecow-tls-secret
minikube stop
minikube delete
\`\`\`

## License

MIT License

## Author

Mayur Karve - [mayur5689]
\`\`\`

**Save and exit**: `Ctrl+X`, `Y`, `Enter`

**Commit and push**:
