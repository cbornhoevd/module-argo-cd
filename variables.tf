variable "aws_region" {
  description = "AWS region ID for deployment (e.g. us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "kubernetes_cluster_id" {
  type = string
}

variable "kubernetes_cluster_cert_data" {
  type = string
}

variable "kubernetes_cluster_endpoint" {
  type = string
}

variable "kubernetes_cluster_name" {
  type = string
}

variable "eks_nodegroup_id" {
  type = string
}
