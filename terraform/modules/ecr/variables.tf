variable "repository_name" {
  description = "Name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting for the ECR repository."
  type        = string
  default     = "MUTABLE"
}

variable "force_delete" {
  description = "Allow Terraform to delete the repository even if it contains images."
  type        = bool
  default     = true
}