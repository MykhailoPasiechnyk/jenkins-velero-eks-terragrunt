# Set common variables for the region. This is automatically pulled in in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  aws_region    = "eu-central-1"
  velero_bucket = "velero-backup-test" # bucket for velero backups
}
