variable "project" {
    description = "GCP Project ID"
    # Provide your GCP Project ID.
    default = "your-gcp-project-id"
}

variable "region" {
    description = "GCP Region"
    # Provide the GCP region where you want to deploy your resources.
    default = "us-central1"
}

variable "location" {
    description = "Project Location"
    # Provide the location for your resources (e.g. BigQuery dataset)
    default = "northamerica-northeast2"
}

variable "gcs_bucket_name" {
    description = "Name of the GCS bucket to be created"
    # Provide a unique name for your GCS bucket.
    default = "your-unique-gcs-bucket-name"
}

variable "bigquery_dataset_name" {
    description = "Name of the BigQuery dataset to be created"
    # Provide a name for your BigQuery dataset.
    default = "your_bigquery_dataset_name"
}

variable "service_account_id" {
    description = "Id of the service account to be created"
    # Provide an ID of 6-30 characters for your service account. E.g. "toronto-development"
    default = "your-service-account-id"
}

variable "iam_roles" {
    type = list(string)
    description = "List of IAM roles to assign to the service account"
    default = [
        "roles/bigquery.dataEditor",
        "roles/bigquery.jobUser",
        "roles/bigquery.user",
        "roles/dataform.admin",
        "roles/storage.admin"
    ]
}