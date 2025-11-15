Azure Spoke Landing Zone (Terraform)

Terraform configuration for deploying an Azure spoke environment following hub-and-spoke architecture principles.
Provides a secure, private foundation for workloads like VMs, Storage Accounts, App Services, or AKS, with centralized monitoring and networking.

Variables:

environment      = "production"
environment_code = "p"
location         = "eastus"


🗂 Repository Structure

infra-terraform-setup/
├── Environments/
│   ├── Dev/
│   │   ├── dev.tfbackend      # Backend configuration for Dev
│   │   └── dev.tfvars        # Variable values for Dev
│   └── Production/
│       ├── prod.tfbackend    # Backend configuration for Prod
│       └── prod.tfvars      # Variable values for Prod
├── compute.tf
├── networking.tf
├── storage.tf
├── variables.tf
└── locals.tf


🚀 Terraform Workflow

terraform init --backend-config=Environments/Dev/dev.tfbackend
terraform fmt -recursive
terraform validate
terraform plan -var-file=Environments/Dev/dev.tfvars
terraform apply -var-file=Environments/Dev/dev.tfvars


terraform init --backend-config=Environments/Production/prod.tfbackend
terraform fmt -recursive
terraform validate
terraform plan -var-file=Environments/Production/prod.tfvars
terraform apply -var-file=Environments/Production/prod.tfvars


🧱 Future Scope

- Add more Resources modules
- Implement IaC linting (tflint, checkov) for quality checks
- Set up GitHub Actions workflows for CI/CD automation