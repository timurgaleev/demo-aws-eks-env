module "network" {
  source = "github.com/timurgaleev/demo-terraform-vpc"

  availability_zones = var.availability_zones
  project            = local.project
  cluster_name       = local.cluster_name
  network            = 10
}

module "kubernetes" {
  depends_on = [module.network]

  source = "github.com/timurgaleev/demo-terraform-eks"

  project            = local.project
  domains            = local.domain
  availability_zones = var.availability_zones
  cluster_name       = local.cluster_name
  vpc_id             = module.network.vpc_id
  subnets            = module.network.private_subnets
  admin_arns = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/tgaleev"
      username = "tgaleev"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/okhomenko"
      username = "okhomenko"
      groups   = ["system:masters"]
    }
  ]
  user_arns = []
}

module "external_dns" {
  depends_on = [module.kubernetes]

  source = "github.com/timurgaleev/demo-terraform-dns"

  cluster_name = module.kubernetes.cluster_name
  mainzoneid   = data.aws_route53_zone.this.zone_id
  hostedzones  = local.domain
  tags         = local.tags
}

module "nginx-ingress" {
  depends_on = []

  source = "github.com/timurgaleev/demo-terraform-controller"

  cluster_name = module.kubernetes.cluster_name
  conf         = {}
  tags         = local.tags
}

module "letsencrypt" {
  depends_on = []

  source = "github.com/timurgaleev/demo-terraform-letsencrypt"

  cluster_name = module.kubernetes.cluster_name
  vpc_id       = module.network.vpc_id
  email        = "timur_galeev@outlook.com"
  zone_id      = module.external_dns.zone_id
  domains      = local.domain
}

# module "grafana" {
#   depends_on = []

#   source = "github.com/timurgaleev/demo-terraform-grafana"

#   cluster_name     = module.kubernetes.cluster_name
#   domains          = local.domain
#   grafana_password = "password"
#   thanos_password  = "password"
#   grafana_conf = {
#     "grafana.env.GF_USER_AUTO_ASSIGN_ORG_ROLE" = "EDITOR"
#     "grafana.env.GF_USER_EDITORS_CAN_ADMIN"    = "true"
#   }
# }
