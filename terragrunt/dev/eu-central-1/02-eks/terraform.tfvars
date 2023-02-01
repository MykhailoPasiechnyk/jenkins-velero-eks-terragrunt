# ---------------EKS Settings----------------------
cluster_name                       = "cluster"
cluster_version                    = "1.23"
worker_group_instance_types        = ["t3.medium"]
autoscaling_group_min_size         = 1
autoscaling_group_max_size         = 1
autoscaling_group_desired_capacity = 1
cluster_endpoint_public_access     = true
