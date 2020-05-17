resource "aws_route53_zone" "domain_zone" {
  name = var.domain
}

resource "aws_route53_record" "domain_nameservers" {
  zone_id         = aws_route53_zone.domain_zone.zone_id
  name            = aws_route53_zone.domain_zone.name
  type            = "NS"
  ttl             = "30"
  allow_overwrite = true

  records = [
    aws_route53_zone.domain_zone.name_servers.0,
    aws_route53_zone.domain_zone.name_servers.1,
    aws_route53_zone.domain_zone.name_servers.2,
    aws_route53_zone.domain_zone.name_servers.3,
  ]
}

resource "aws_route53_record" "site" {
  name    = var.domain
  type    = "A"
  zone_id = aws_route53_zone.domain_zone.zone_id

  alias {
    name                   = aws_cloudfront_distribution.site_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.site_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}