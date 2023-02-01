variable "cluster_name" {
  type        = string
  description = "EKS Cluster name"
  default     = null
}

variable "cluster_version" {
  type        = string
  description = "EKS engine version"
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "Identifiers of EC2 Subnets to associate with the EKS Node Group."
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the cluster security group will be provisioned"
  default     = null
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  default     = false
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate"
  default     = []
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "worker_group_instance_types" {
  type        = list(string)
  description = "value"
  default     = []
}

variable "autoscaling_group_min_size" {
  type        = number
  description = "Minimum number of instances/nodes"
  default     = 0
}

variable "autoscaling_group_max_size" {
  type        = number
  description = "Maximum number of instances/nodes"
  default     = 0
}

variable "autoscaling_group_desired_capacity" {
  type        = number
  description = "Desired number of instances/nodes"
  default     = 0
}
