variable "env" {
  type        = string
  description = "Environment"
}

variable "velero_bucket" {
  type        = string
  description = "S3 Bucket for Velero backups"
}

variable "velero_user" {
  type        = string
  description = "Velero user name"
}
