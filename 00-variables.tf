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

variable "domain_name" {
  default     = "godapp.de"
  type        = string
  description = "Domain name"
}

variable "project" {
  default     = "god-prod"
  type        = string
  description = "A value that will be used in annotations and tags to identify resources with the `Project` key"
}

variable "zone_id" {
  default     = "Z01947971XH87F079JF0L"
  type        = string
  description = "Default zone id for root domain" #like Z04917561CQAI9UAF27D6
}
