variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "Region where the resources will be created"
  type        = string
}

variable "instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "Cloud SQL database version"
  type        = string
}

variable "tier" {
  description = "Machine tier"
  type        = string
}

variable "database_name" {
  description = "Database name for the Cloud SQL instance"
  type        = string
}

variable "user_name" {
  description = "User name for the Cloud SQL instance"
  type        = string
}

variable "user_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "static_bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "domain" {
  description = "Domain name for the SSL certificate"
  type        = string
  default     = ""
}
