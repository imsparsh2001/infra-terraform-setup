# 🚀 Azure Spoke Landing Zone (Terraform)

This repository contains **Terraform IaC** to deploy Azure Spoke Landing Zones, including **Azure Red Hat OpenShift (ARO)** clusters and all required Azure infrastructure.

---

## 📦 Repository Structure

```
├── environments/              # Environment-specific configs
│   ├── dev/
│   ├── stg/
│   └── production/
├── .github/workflows/         # CI/CD Pipelines
├── aro.tf
├── aroinfra.tf
├── networking.tf
├── resources.tf
├── storage.tf
├── monitoring.tf
├── dns.tf
├── data.tf
├── locals.tf
├── variables.tf
├── outputs.tf
└── provider.tf
```

---

## ✅ Requirements

Before deploying, ensure you have:

* Azure Subscription with contributor access
* Terraform **v1.6.0+**
* Azure CLI installed & logged in
* Red Hat OpenShift pull secret
* GitHub repository configured with **OIDC authentication**

---

## ⚡ Quick Start Deployment


### Development

```bash
terraform init -backend-config=environments/dev/dev.tfbackend
terraform plan -var-file=environments/dev/dev.tfvars
terraform apply -var-file=environments/dev/dev.tfvars -auto-approve
```

### Staging

```bash
terraform init -backend-config=environments/stg/stage.tfbackend
terraform plan -var-file=environments/dev/stage.tfvars
terraform apply -var-file=environments/stg/stage.tfvars -auto-approve
```

### Production

```bash
terraform init -backend-config=environments/production/prod.tfbackend
terraform plan -var-file=environments/dev/prod.tfvars
terraform apply -var-file=environments/production/prod.tfvars
```
---
## 🌍 Environment Files

Each environment includes:

| File              | Purpose                        |
| ----------------- | ------------------------------ |
| `<env>.tfbackend` | Remote state configuration     |
| `<env>.tfvars`    | Environment-specific variables |

Paths:

* Dev → `environments/dev/`
* Staging → `environments/stg/`
* Prod → `environments/production/`

---

## 🔁 CI/CD Pipelines

Automated GitHub Actions workflows:

| Workflow              | Purpose                          |
| --------------------- | -------------------------------- |
| terraform-plan.yml    | Validate & plan on pull requests |
| terraform-apply.yml   | Apply after approval             |
| terraform-destroy.yml | Manual teardown                  |
| scheduled-create.yml  | Automated deployment             |
| scheduled-destroy.yml | Scheduled cleanup                |
| commands.yml          | Maintenance & admin operations   |


