locals {
  common_tags = {}
}

resource "aws_acm_certificate" "cert" {
  domain_name = var.common_name

  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method

  tags = merge(local.common_tags, var.custom_tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count   = var.existing_validation ? 0 : 1
  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id = var.hosted_zone_id
  records = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  ttl     = var.default_ttl
}

resource "aws_acm_certificate_validation" "cert" {
  count           = var.existing_validation ? 0 : 1
  certificate_arn = "${aws_acm_certificate.cert.arn}"

  validation_record_fqdns = [
    "${aws_route53_record.cert_validation[count.index].fqdn}",
  ]
}

output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}
