moved {
  from = google_artifact_registry_repository.docker_repo
  to   = module.artifact_registry.google_artifact_registry_repository.docker_repo
}

moved {
  from = google_cloud_run_v2_service.php_app
  to   = module.cloud_run.google_cloud_run_v2_service.php_app
}

moved {
  from = google_cloud_run_v2_service_iam_member.public_access
  to   = module.cloud_run.google_cloud_run_v2_service_iam_member.public_access[0]
}

moved {
  from = google_sql_database_instance.sql_instance
  to   = module.cloud_sql.google_sql_database_instance.sql_instance
}

moved {
  from = google_sql_database.sql_database
  to   = module.cloud_sql.google_sql_database.sql_database
}

moved {
  from = google_sql_user.sql_user
  to   = module.cloud_sql.google_sql_user.sql_user
}

moved {
  from = google_storage_bucket.static_bucket
  to   = module.static_bucket.google_storage_bucket.static_bucket
}

moved {
  from = google_storage_bucket_iam_member.public_read
  to   = module.static_bucket.google_storage_bucket_iam_member.public_read
}

moved {
  from = google_project_iam_member.artifact_registry_writer
  to   = module.github_actions_iam.google_project_iam_member.artifact_registry_writer
}

moved {
  from = google_project_iam_member.cloud_run_admin
  to   = module.github_actions_iam.google_project_iam_member.cloud_run_admin
}

moved {
  from = google_service_account_iam_member.service_account_user
  to   = module.github_actions_iam.google_service_account_iam_member.service_account_user
}

moved {
  from = google_compute_global_address.lb_ip
  to   = module.http_lb.google_compute_global_address.lb_ip
}

moved {
  from = google_compute_region_network_endpoint_group.cloud_run_neg
  to   = module.http_lb.google_compute_region_network_endpoint_group.cloud_run_neg
}

moved {
  from = google_compute_backend_service.cloud_run_backend
  to   = module.http_lb.google_compute_backend_service.cloud_run_backend
}

moved {
  from = google_compute_url_map.url_map
  to   = module.http_lb.google_compute_url_map.url_map
}

moved {
  from = google_compute_managed_ssl_certificate.ssl_cert
  to   = module.http_lb.google_compute_managed_ssl_certificate.ssl_cert
}

moved {
  from = google_compute_target_https_proxy.https_proxy
  to   = module.http_lb.google_compute_target_https_proxy.https_proxy
}

moved {
  from = google_compute_global_forwarding_rule.https_forwarding_rule
  to   = module.http_lb.google_compute_global_forwarding_rule.https_forwarding_rule
}

moved {
  from = google_compute_target_http_proxy.http_proxy
  to   = module.http_lb.google_compute_target_http_proxy.http_proxy
}

moved {
  from = google_compute_global_forwarding_rule.http_forwarding_rule
  to   = module.http_lb.google_compute_global_forwarding_rule.http_forwarding_rule
}

# Project services (for_each instances). Add one moved block per enabled API.
moved {
  from = google_project_service.services["artifactregistry.googleapis.com"]
  to   = module.project_services.google_project_service.services["artifactregistry.googleapis.com"]
}
moved {
  from = google_project_service.services["cloudresourcemanager.googleapis.com"]
  to   = module.project_services.google_project_service.services["cloudresourcemanager.googleapis.com"]
}
moved {
  from = google_project_service.services["compute.googleapis.com"]
  to   = module.project_services.google_project_service.services["compute.googleapis.com"]
}
moved {
  from = google_project_service.services["iam.googleapis.com"]
  to   = module.project_services.google_project_service.services["iam.googleapis.com"]
}
moved {
  from = google_project_service.services["iamcredentials.googleapis.com"]
  to   = module.project_services.google_project_service.services["iamcredentials.googleapis.com"]
}
moved {
  from = google_project_service.services["run.googleapis.com"]
  to   = module.project_services.google_project_service.services["run.googleapis.com"]
}
moved {
  from = google_project_service.services["servicenetworking.googleapis.com"]
  to   = module.project_services.google_project_service.services["servicenetworking.googleapis.com"]
}
moved {
  from = google_project_service.services["serviceusage.googleapis.com"]
  to   = module.project_services.google_project_service.services["serviceusage.googleapis.com"]
}
moved {
  from = google_project_service.services["sqladmin.googleapis.com"]
  to   = module.project_services.google_project_service.services["sqladmin.googleapis.com"]
}
moved {
  from = google_project_service.services["storage.googleapis.com"]
  to   = module.project_services.google_project_service.services["storage.googleapis.com"]
}
