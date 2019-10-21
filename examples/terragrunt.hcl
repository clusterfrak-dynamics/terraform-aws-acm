include {
  path = "${find_in_parent_folders()}"
}

terraform {
  source = "github.com/clusterfrak-dynamics/terraform-aws-acm.git?ref=v1.0.0"
}

locals {
  aws_region   = basename(dirname(get_terragrunt_dir()))
  env         = "production"
  custom_tags = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("common_tags.yaml")}"))
}

inputs = {

  env = local.env

  aws = {
    "region" = local.aws_region
  }

  custom_tags = merge(
    {
      Env = local.env
    },
    local.custom_tags
  )

  common_name = "*.domain.name"
  domain_name = "domain.name"
  validation_method = "DNS"
  subject_alternative_names = []
  default_ttl = 60
  existing_validation = false
}
