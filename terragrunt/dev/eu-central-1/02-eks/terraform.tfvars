# ---------------EKS Settings----------------------
cluster_name                       = "cluster"
cluster_version                    = "1.23"
worker_group_instance_type         = ["t3.medium"]
autoscaling_group_min_size         = 1
autoscaling_group_max_size         = 1
autoscaling_group_desired_capacity = 1
