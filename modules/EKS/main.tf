module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.5.1"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    instance_types = var.worker_group_instance_types

    attach_cluster_primary_security_group = false
    vpc_security_group_ids                = var.vpc_security_group_ids
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = var.autoscaling_group_min_size
      max_size     = var.autoscaling_group_max_size
      desired_size = var.autoscaling_group_desired_capacity

      instance_types = var.worker_group_instance_types
      capacity_type  = "SPOT"
      labels = {
        Environment = var.env
      }
    }
  }
}
