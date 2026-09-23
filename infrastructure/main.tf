terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "7.24.0"
      }
    }
}

provider "google" {
    project = var.project
    region  = var.region
}

# ------------------------------------------------------------------------------
# IAM Management - Service Account Creation
# ------------------------------------------------------------------------------
resource "google_service_account" "toronto_development_service_account" {
    account_id = var.service_account_id
    display_name = "Toronto Development Service Account"
}

resource "google_project_iam_member" "member_role" {
    for_each = toset(var.iam_roles)
    role    = each.value
    project = var.project
    member  = "serviceAccount:${google_service_account.toronto_development_service_account.email}"
    depends_on = [google_service_account.toronto_development_service_account]
}

# Grants YOUR current user permission to impersonate this new Service Account
resource "google_service_account_iam_member" "user_impersonation_permission" {
  service_account_id = google_service_account.toronto_development_service_account.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "user:${var.me_user_email}"
}

# Generate Impersonated Access Token - Requests short-lived credentials for the newly created SA
data "google_service_account_access_token" "sa_token" {
  provider               = google
  target_service_account = google_service_account.toronto_development_service_account.email
  scopes                 = ["https://www.googleapis.com/auth/cloud-platform"]
  lifetime               = "1200s"

  # Ensure the SA and IAM permissions exist before requesting the token
  depends_on = [
    google_project_iam_member.member_role,
    google_service_account_iam_member.user_impersonation_permission
  ]
}

# Aliased Provider (Impersonated) - Authenticates using the dynamically generated access token
provider "google" {
  alias        = "impersonated"
  project      = var.project
  region       = var.region
  access_token = data.google_service_account_access_token.sa_token.access_token
}

# ------------------------------------------------------------------------------
# GCP Resource Creation with new service account
# ------------------------------------------------------------------------------
resource "google_storage_bucket" "development_data_bucket" {
    provider = google.impersonated
    
    name = var.gcs_bucket_name
    location = var.location
    force_destroy = true

    lifecycle_rule {
        condition {
            age = 1
        }
        action {
            type = "AbortIncompleteMultipartUpload"
        }
    }
}

resource "google_bigquery_dataset" "development_data_dataset" {
    provider = google.impersonated
    
    dataset_id = var.bigquery_dataset_name
    location = var.location
}