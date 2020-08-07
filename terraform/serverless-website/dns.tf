resource "aws_route53_zone" "zone" {
  name = var.root_domain
}

// Workaround to get lower NS ttl for root domain
resource "aws_route53_record" "ns" {
  allow_overwrite = true
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.root_domain
  type    = "NS"
  ttl     = "172800"
  records = [
    aws_route53_zone.zone.name_servers[0],
    aws_route53_zone.zone.name_servers[1],
    aws_route53_zone.zone.name_servers[2],
    aws_route53_zone.zone.name_servers[3],
  ]
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.www_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "non-www" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.non-www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.non-www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-ipv6" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.www_domain
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "non-www-ipv6" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = ""
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.non-www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.non-www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "gsuite_mx" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = ""
  type    = "MX"

  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
  ]

  ttl = "3600"
}
