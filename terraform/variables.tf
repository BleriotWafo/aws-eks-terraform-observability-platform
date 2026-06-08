variable "project_name" {
  description = "Name of the project used for AWS resource naming."
  type        = string
  default     = "eks-observability-platform"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed."
  type        = string
  default     = "eu-central-1"
}

variable "owner" {
  description = "Owner of the infrastructure."
  type        = string
  default     = "Bleriot Wafo"
}

variable "vpc_cidr" {
  description = "CIDR block used for the project VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks used for public subnets."
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "eks_cluster_version" {
  description = "Kubernetes version used by the EKS cluster."
  type        = string
  default     = "1.34"
}

variable "node_instance_types" {
  description = "EC2 instance types used by the EKS managed node group."
  type        = list(string)
  default     = ["t3.small"]
}

variable "node_desired_size" {
  description = "Desired number of worker nodes."
  type        = number
  default     = 1
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 2
}