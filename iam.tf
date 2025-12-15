resource "google_project_iam_member" "artifact_registry_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${var.github_service_account}"

  depends_on = [google_project_service.services]
}

resource "google_project_iam_member" "cloud_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${var.github_service_account}"

  depends_on = [google_project_service.services]
}

resource "google_service_account_iam_member" "service_account_user" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.github_service_account}"
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.github_service_account}"

  depends_on = [google_project_service.services]
}
