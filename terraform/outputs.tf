output "aws_account_id" {
  description = "AWS account ID used by Terraform."
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "AWS region used by Terraform."
  value       = data.aws_region.current.region
}

output "project_name" {
  description = "Project name."
  value       = var.project_name
}

output "environment" {
  description = "Deployment environment."
  value       = var.environment
}

output "name_prefix" {
  description = "Name prefix used for AWS resources."
  value       = local.name_prefix
}

output "backend_ecr_repository_name" {
  description = "Backend ECR repository name."
  value       = module.ecr_backend.repository_name
}

output "backend_ecr_repository_url" {
  description = "Backend ECR repository URL."
  value       = module.ecr_backend.repository_url
}

output "backend_ecr_repository_arn" {
  description = "Backend ECR repository ARN."
  value       = module.ecr_backend.repository_arn
}