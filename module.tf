module "eks-network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = local.tags
}

module "eks-cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = local.tags
  public_subnet_1a = module.eks-network.subnet_pub_1a
  public_subnet_1b = module.eks-network.subnet_pub_1b
}

module "managed-node-group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  tags              = local.tags
  cluster_name      = module.eks-cluster.cluster_name
  subnet_private_1a = module.eks-network.subnet_private_1a
  subnet_private_1b = module.eks-network.subnet_private_1b

}