resource "google_cloud_run_v2_service" "php_app" {
  name     = "php-app"
  location = var.region
  project  = var.project_id

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      env {
        name  = "APP_ENV"
        value = var.environment
      }

      env {
        name  = "DB_HOST"
        value = google_sql_database_instance.sql_instance.private_ip_address
      }

      env {
        name  = "DB_NAME"
        value = var.database_name
      }

      env {
        name  = "DB_USER"
        value = var.user_name
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  depends_on = [google_project_service.services]

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,
    ]
  }
}

resource "google_cloud_run_v2_service_iam_member" "public_access" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.php_app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "cloud_run_url" {
  value = google_cloud_run_v2_service.php_app.uri
}
