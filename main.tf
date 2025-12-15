resource "google_sql_database_instance" "sql_instance" {
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
  instance = google_sql_database_instance.this.name
  project  = var.project_id
}

resource "google_sql_user" "sql_user" {
  name     = var.user_name
  instance = google_sql_database_instance.this.name
  project  = var.project_id
  password = var.user_password
}
