module "github_actions_iam" {
  source                 = "${local.modules_repo}//modules/github_actions_iam?ref=${local.modules_ref}"
  project_id             = var.project_id
  github_service_account = var.github_service_account

  depends_on = [module.project_services]
}
