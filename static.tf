resource "google_storage_bucket" "static_bucket" {
  project       = var.project_id
  name          = "${var.static_bucket_name}-${var.environment}"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_iam_member" "public_read" {
  bucket = google_storage_bucket.static_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

output "static_bucket_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.static_bucket.name}"
}
