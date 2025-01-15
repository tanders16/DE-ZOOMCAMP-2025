variable "credentials" {
  description = "Google Credentials"
  default     = "./keys/my-creds.json"
}

variable "project" {
  description = "Project"
  default     = "electric-goods-447200-j0"
}

variable "project_region" {
  description = "Project Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_storage_class" {
  description = "Storage Bucket Class"
  default     = "STANDARD"
}

variable "gcs_bucket_name" {
  description = "Storage Bucket Name"
  default     = "electric-goods-447200-j0-terra-bucket"
}


