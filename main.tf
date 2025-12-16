module "project_services" {
  # module.source must be a literal string (no locals/vars).
  source     = "git::https://github.com/cosminmcnoprea-pixel/terraform-modules.git//project_services?ref=main"
  project_id = var.project_id
}

module "cloud_sql" {
  source           = "git::https://github.com/cosminmcnoprea-pixel/terraform-modules.git//cloud_sql_mysql?ref=main"
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
