output "resources" {
  description = "List of objects containing information about underlying resources."
  value       = aws_eks_node_group.node00.resources
}