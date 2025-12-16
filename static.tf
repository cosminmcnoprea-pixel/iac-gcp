module "static_bucket" {
  source             = "${local.modules_repo}//modules/static_bucket_public?ref=${local.modules_ref}"
  project_id         = var.project_id
  region             = var.region
  static_bucket_name = var.static_bucket_name
  environment        = var.environment

  depends_on = [module.project_services]
}

output "static_bucket_url" {
  value = module.static_bucket.static_bucket_url
}
