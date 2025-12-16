module "github_actions_iam" {
  source                 = "git::https://github.com/cosminmcnoprea-pixel/terraform-modules.git//github_actions_iam?ref=main"
  project_id             = var.project_id
  github_service_account = var.github_service_account

  depends_on = [module.project_services]
}
