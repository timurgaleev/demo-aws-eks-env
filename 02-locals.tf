locals {
  project      = var.project
  cluster_name = var.cluster_name
  tags = {
    project = local.project
  }
}
