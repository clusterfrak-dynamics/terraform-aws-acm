variable "env" {}

variable "aws" {
  type    = any
  default = {}
}

variable "custom_tags" {
  type    = map
  default = {}
}

variable "validation_method" {
  description = "Method to use for validation, `DNS` or `EMAIL` are valid"
}

variable "existing_validation" {
  description = "Set to true is DNS validation already exists"
  default     = false
}

variable "common_name" {
  description = "A domain name for which the certificate should be issued"
}

variable "hosted_zone_id" {
  description = "A zone_id for which the certificate should be issued"
}

variable "subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = "list"
}

variable "default_ttl" {
  description = "record that specifies how long a resolver is supposed to cache (or remember) the DNS query before the query expires and a new one needs to be done"
}
