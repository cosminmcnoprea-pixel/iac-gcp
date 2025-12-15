variable "domain" {
  description = "Domain name for the SSL certificate"
  type        = string
  default     = ""
}

resource "google_compute_global_address" "lb_ip" {
  project = var.project_id
  name    = "php-app-lb-ip"

  depends_on = [google_project_service.services]
}

resource "google_compute_region_network_endpoint_group" "cloud_run_neg" {
  project               = var.project_id
  name                  = "php-app-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region

  cloud_run {
    service = google_cloud_run_v2_service.php_app.name
  }
}

resource "google_compute_backend_service" "cloud_run_backend" {
  project = var.project_id
  name    = "php-app-backend"

  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.cloud_run_neg.id
  }
}

resource "google_compute_url_map" "url_map" {
  project         = var.project_id
  name            = "php-app-url-map"
  default_service = google_compute_backend_service.cloud_run_backend.id
}

resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  project = var.project_id
  name    = "php-app-ssl-cert"

  managed {
    domains = [var.domain != "" ? var.domain : "${google_compute_global_address.lb_ip.address}.nip.io"]
  }
}

resource "google_compute_target_https_proxy" "https_proxy" {
  project          = var.project_id
  name             = "php-app-https-proxy"
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_cert.id]
}

resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  project    = var.project_id
  name       = "php-app-https-forwarding-rule"
  target     = google_compute_target_https_proxy.https_proxy.id
  port_range = "443"
  ip_address = google_compute_global_address.lb_ip.address
}

resource "google_compute_target_http_proxy" "http_proxy" {
  project = var.project_id
  name    = "php-app-http-proxy"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  project    = var.project_id
  name       = "php-app-http-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.lb_ip.address
}

output "load_balancer_ip" {
  value       = google_compute_global_address.lb_ip.address
  description = "The IP address of the load balancer"
}

output "load_balancer_fqdn" {
  value       = var.domain != "" ? var.domain : "${google_compute_global_address.lb_ip.address}.nip.io"
  description = "The FQDN to access the application"
}
