output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = aws_eks_cluster.this.arn
}

output "cluster_version" {
  description = "Kubernetes version of the EKS cluster."
  value       = aws_eks_cluster.this.version
}

output "node_group_name" {
  description = "Name of the EKS managed node group."
  value       = aws_eks_node_group.default.node_group_name
}

output "node_role_arn" {
  description = "ARN of the EKS node IAM role."
  value       = aws_iam_role.eks_node_role.arn
}