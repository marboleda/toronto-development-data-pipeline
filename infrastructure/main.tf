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

resource "google_service_account" "toronto_development_service_account" {
    account_id = var.service_account_id
    display_name = "Toronto Development Service Account"
}

resource "google_project_iam_member" "member-role" {
    for_each = toset(var.iam_roles)
    role    = each.value
    project = var.project
    member  = "serviceAccount:${google_service_account.toronto_development_service_account.email}"
    depends_on = [google_service_account.toronto_development_service_account]
}

resource "google_storage_bucket" "development_data_bucket" {
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
    dataset_id = var.bigquery_dataset_name
    location = var.location
}