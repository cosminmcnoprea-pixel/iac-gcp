module "static_bucket" {
  source             = "git::https://github.com/cosminmcnoprea-pixel/terraform-modules.git//static_bucket?ref=main"
  project_id         = var.project_id
  region             = var.region
  static_bucket_name = var.static_bucket_name
  environment        = var.environment

  depends_on = [module.project_services]
}

output "static_bucket_url" {
  value = module.static_bucket.static_bucket_url
}
