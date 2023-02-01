variable "velero_bucket" {
  type        = string
  description = "S3 Backet for Velero backups"
}

variable "cluster_name" {}

variable "path_to_values" {}

variable "secret_file" {}
