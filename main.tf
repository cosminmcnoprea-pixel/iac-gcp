module "project_services" {
  source     = "${local.modules_repo}//modules/project_services?ref=${local.modules_ref}"
  project_id = var.project_id
}

module "cloud_sql" {
  source           = "${local.modules_repo}//modules/cloud_sql_mysql?ref=${local.modules_ref}"
  project_id       = var.project_id
  region           = var.region
  instance_name    = var.instance_name
  database_version = var.database_version
  tier             = var.tier
  database_name    = var.database_name
  user_name        = var.user_name
  user_password    = var.user_password

  depends_on = [module.project_services]
}
