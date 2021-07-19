# About

Simple installation of EKS and VPC via terraform

# Install cluster
Change variables.tf

Prepare and download modules

`terraform init`

Plan and test deployment

`terraform plan`

Deploy cluster and helm charts

`terraform apply`

# Structure
  main.tf - the main Terraform file with infrastructure code

  providers.tf - list of providers and their values
