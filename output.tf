output "subnet_pub_1a" {
  value = module.eks-network.subnet_pub_1a
}
output "eks_vpc_config" {
  value = module.eks-cluster.eks_vpc_config
}

output "oidc" {
  value = module.eks-cluster.oidc
}