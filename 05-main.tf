module "network" {
  source = "github.com/GOD-mbh/god-terraform-vpc"

  availability_zones = var.availability_zones
  project            = local.project
  cluster_name       = local.cluster_name
  network            = 10
}

module "kubernetes" {
  depends_on = [module.network]
  source     = "github.com/GOD-mbh/god-terraform-eks"

  project            = local.project
  availability_zones = var.availability_zones
  cluster_name       = local.cluster_name
  vpc_id             = module.network.vpc_id
  subnets            = module.network.private_subnets
  admin_arns = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/tgaleev"
      username = "tgaleev"
      groups   = ["system:masters"]
    }
  ]
  user_arns = []
}