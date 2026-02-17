# kong-api-training-module3

This repository demonstrates how to deploy Kong API Gateway (Traditional / DB-backed Mode) across different environments:
- 🐳 Docker (Local Development)
- ☸️ Kubernetes (Helm-based Deployment)
- 🖥️ Linux VM (Ubuntu Installation)

The goal of this repository is to help you understand Kong architecture and deployment patterns across multiple infrastructure layers.

## Repository Structure
```
├── docker/
│   └── Docker Compose setup (Postgres + Kong)
│
├── kubernetes/
│   └── Helm-based deployment (CloudNativePG + Kong)
│
└── vm/
    └── Ubuntu VM installation scripts (Postgres + Kong)
```

## Deployment Models Covered
|Environment|Mode|Recommended For|
|Docker|Traditional|Local testing & learning|
|Kubernetes|Traditional (Helm)|Cloud-native environments|
|VM (Ubuntu)|Traditional|Bare metal / IaaS VMs|

**All deployments use:**
- PostgreSQL (Datastore)
- Kong Gateway 3.9
- Traditional Mode (DB-backed)

## Quick Start
Choose your preferred environment:
- 1️⃣ Docker (Fastest for Local Lab)
- 2️⃣ Kubernetes (Helm Deployment)
- 3️⃣ VM (Ubuntu Traditional Install)

## Important Notes

⚠️ These setups are intended for:
- Learning
- Sandbox
- Internal training
- Development