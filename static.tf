resource "google_storage_bucket" "static_bucket" {
  project       = var.project_id
  name          = "${var.static_bucket_name}-${var.environment}"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true
}
