
module "http_lb" {
  source                 = "git::https://github.com/cosminmcnoprea-pixel/terraform-modules.git//http_lb_cloud_run?ref=main"
  project_id            = var.project_id
  region                = var.region
  name                  = "php-app"
  cloud_run_service_name = module.cloud_run.service_name
  domain                = var.domain

  depends_on = [module.project_services, module.cloud_run]
}

output "load_balancer_ip" {
  value = module.http_lb.lb_ip_address
}
