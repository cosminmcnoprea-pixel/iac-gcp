## terraform (infra)

Root Terraform config that provisions:
- Cloud SQL (MySQL)
- static GCS bucket
- Cloud Run service
- global HTTP(S) load balancer pointing to Cloud Run
- IAM for GitHub Actions (WIF)

### Prereqs
- Terraform 1.5+

### Backend
Backend configs are in:
- `backend-dev.tfbackend`
- `backend-prod.tfbackend`

### Deploy (local)

```bash
terraform init -backend-config=backend-dev.tfbackend
terraform plan  -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

Prod is the same idea with `backend-prod.tfbackend` + `prod.tfvars`.

### Terraform in GitHub Actions
Workflow is `terraform/.github/workflows/terraform.yml` and uses WIF secrets:
- `WIF_PROVIDER_DEV`, `WIF_SERVICE_ACCOUNT_DEV`
- `WIF_PROVIDER_PROD`, `WIF_SERVICE_ACCOUNT_PROD`

It also uses `USER_PASSWORD` (exported as `TF_VAR_user_password`).
