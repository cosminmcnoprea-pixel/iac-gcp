module "artifact_registry" {
  source        = "${local.modules_repo}//modules/artifact_registry_docker?ref=${local.modules_ref}"
  project_id    = var.project_id
  region        = var.region
  repository_id = "docker-repo"
  reader_member = var.environment == "dev" ? "serviceAccount:service-account-iac@global-reach-media-prod.iam.gserviceaccount.com" : ""

  depends_on = [module.project_services]
}
