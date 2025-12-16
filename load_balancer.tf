
module "http_lb" {
  source                = "${local.modules_repo}//modules/http_lb_cloud_run?ref=${local.modules_ref}"
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
