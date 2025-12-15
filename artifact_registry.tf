resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.project_id
  location      = var.region
  repository_id = "docker-repo"
  format        = "DOCKER"
  description   = "Docker repository for Cloud Run services"

  depends_on = [google_project_service.services]
}
