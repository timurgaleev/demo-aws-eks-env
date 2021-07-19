variable "cluster_name" {
  default     = "demo-env"
  type        = string
  description = "A name of the Amazon EKS cluster"
}

variable "region" {
  default     = "eu-north-1"
  type        = string
  description = "Set default region"
}

variable "availability_zones" {
  default     = ["eu-north-1a", "eu-north-1b"]
  type        = list(any)
  description = "Availability zones for project, minimum 2"
}

variable "project" {
  default     = "god-prod"
  type        = string
  description = "A value that will be used in annotations and tags to identify resources with the `Project` key"
}
