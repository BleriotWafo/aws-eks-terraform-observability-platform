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