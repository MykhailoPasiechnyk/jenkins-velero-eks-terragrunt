include {
	path = find_in_parent_folders()
}

dependency "network" {
	config_path = "../01-network"
}

terraform {
	source = "${get_parent_terragrunt_dir()}/..//modules/EKS"
}

inputs = {
  subnet_ids             = [dependency.network.outputs.public_subnet_1_id, dependency.network.outputs.public_subnet_2_id]
  vpc_id                 = dependency.network.outputs.vpc_id
  vpc_security_group_ids = [dependency.network.outputs.sg_allow_web_traffic_id]
}

dependencies {
  paths = ["../01-network", "../iam"]
}
