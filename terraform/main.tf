data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  name_prefix     = "${var.project_name}-${var.environment}"
  cluster_name    = "${local.name_prefix}-eks"
  node_group_name = "${local.name_prefix}-node-group"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }
}

module "vpc" {
  source = "./modules/vpc"

  name_prefix         = local.name_prefix
  cluster_name        = local.cluster_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_cidrs))
}

module "ecr_backend" {
  source = "./modules/ecr"

  repository_name = "${local.name_prefix}-backend"
}

module "eks" {
  source = "./modules/eks"

  cluster_name        = local.cluster_name
  cluster_version     = var.eks_cluster_version
  subnet_ids          = module.vpc.public_subnet_ids
  node_group_name     = local.node_group_name
  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
}