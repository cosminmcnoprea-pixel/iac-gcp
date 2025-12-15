locals {
  services = [
    "sqladmin.googleapis.com",
  ]
}

resource "google_project_service" "services" {
  for_each = toset(local.services)
  project  = var.project_id
  service  = each.value

  disable_on_destroy = false
}

resource "google_sql_database_instance" "sql_instance" {
  depends_on       = [google_project_service.services]
  name             = var.instance_name
  project          = var.project_id
  region           = var.region
  database_version = var.database_version

  settings {
    tier = var.tier
  }

  deletion_protection = false
}

resource "google_sql_database" "sql_database" {
  name     = var.database_name
  instance = google_sql_database_instance.sql_instance.name
  project  = var.project_id
}

resource "google_sql_user" "sql_user" {
  name     = var.user_name
  instance = google_sql_database_instance.sql_instance.name
  project  = var.project_id
  password = var.user_password
}
