resource "aws_acm_certificate" "certificate" {
  domain_name = var.domain
  validation_method = "DNS"

  subject_alternative_names = [ "*.${aws_route53_zone.domain_zone.name}" ]

  lifecycle {
    create_before_destroy = true
  }

  provider = aws.us-east-1
}

resource "aws_route53_record" "certificate_validation" {
  name    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type
  records = [ aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value ]
  zone_id = aws_route53_zone.domain_zone.zone_id
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [ aws_route53_record.certificate_validation.fqdn ]

  timeouts {
    create = "2h"
  }

  provider = aws.us-east-1
}