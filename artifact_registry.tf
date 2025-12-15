resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.project_id
  location      = var.region
  repository_id = "docker-repo"
  format        = "DOCKER"
  description   = "Docker repository for Cloud Run services"

  depends_on = [google_project_service.services]
}

# Grant prod service account read access to dev artifact registry (only in dev)
resource "google_artifact_registry_repository_iam_member" "prod_reader" {
  count = var.environment == "dev" ? 1 : 0

  project    = var.project_id
  location   = var.region
  repository = google_artifact_registry_repository.docker_repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:service-account-iac@global-reach-media-prod.iam.gserviceaccount.com"
}
