module "cloud_run" {
  source       = "${local.modules_repo}//modules/cloud_run_v2_service?ref=${local.modules_ref}"
  project_id   = var.project_id
  region       = var.region
  service_name = "php-app"
  image        = "us-docker.pkg.dev/cloudrun/container/hello"

  env_vars = {
    APP_ENV           = var.environment
    DB_HOST           = module.cloud_sql.private_ip_address
    DB_NAME           = var.database_name
    DB_USER           = var.user_name
    STATIC_BUCKET_URL = module.static_bucket.static_bucket_url
  }

  depends_on = [module.project_services, module.cloud_sql, module.static_bucket]
}

output "cloud_run_url" {
  value = module.cloud_run.service_url
}
