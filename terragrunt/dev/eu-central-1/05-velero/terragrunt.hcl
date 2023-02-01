include {
  path = find_in_parent_folders()
}

dependency "eks" {
  config_path = "../02-eks"
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/Velero"
}

inputs = {
  path_to_values = "velero.yaml"
	cluster_name   = dependency.eks.outputs.cluster_name
  secret_file    = "credentials-velero"
}

dependencies {
  paths = ["../02-eks", "../03-k8s_resoursces"]
}
