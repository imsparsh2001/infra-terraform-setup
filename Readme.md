Azure Spoke Landing Zone (Terraform)

Terraform configuration for deploying an Azure spoke environment following hub-and-spoke architecture principles.
Provides a secure, private foundation for workloads like VMs, Storage Accounts, App Services, or AKS, with centralized monitoring and networking.

🧭 Overview

Private, isolated spoke network connected to a central hub

Centralized logging via Log Analytics

Key Vault with private endpoint and restricted access

Modular, extensible design for future services

🗂 Repository Structure
.github/workflows/   → CI/CD automation (plan, apply, destroy)
networking.tf        → VNet, subnets, peerings
monitoring.tf        → Log Analytics + diagnostics
resources.tf         → Key Vault, shared infrastructure
locals.tf            → Naming conventions and static references
environments/        → tfvars & backend configs per environment

🧩 Naming Convention

Pattern:

{spoke}-{resource}-{env_code}-{loc}


Example:

core-vnet-p-eastus


Variables:

environment      = "production"
environment_code = "p"
location         = "eastus"

🚀 Terraform Workflow
terraform init --backend-config=environments/dev/dev.tfbackend
terraform fmt -recursive
terraform validate
terraform plan -var-file=environments/dev/dev.tfvars
terraform apply -auto-approve -var-file=environments/dev/dev.tfvars

🔐 Security Highlights

Private endpoints for Key Vault, Storage, etc.

NSGs applied per subnet for controlled traffic

No public exposure for sensitive services

🧱 Future Scope

Add more Resources modules

Implement IaC linting (tflint, checkov) for quality checks
