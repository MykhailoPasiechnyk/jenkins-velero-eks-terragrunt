locals {
  # Automatically load environment-level variables
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  aws_region = local.region_vars.locals.aws_region
}

# Generate _backend.tf file with remote state configuration
remote_state {
  backend  = "s3"

  generate = {
	path 	  = "_backend.tf"
	if_exists = "overwrite"
  }

  config = {
	bucket 	= "test-terragrunt-state-bucket" # set your bucket name
	region	= "eu-central-1"
	key 	= "${path_relative_to_include()}/terraform.tfstate"
	encrypt = true
  }
}

# Generate providers.tf file with provider configuration
generate "provider" {
  path = "_provider.tf"
  if_exists = "overwrite"

  contents = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

inputs = merge(
  local.env_vars.locals,
  local.region_vars.locals,
)
