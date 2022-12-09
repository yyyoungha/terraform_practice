# SAMPLE APPLICATION WAF WEB ACL

resource "aws_wafv2_web_acl" "sample" {
  name        = "managed-rule-sample"
  description = "sample application rule."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule {
          name = "SizeRestrictions_QUERYSTRING"
        }

        excluded_rule {
          name = "NoUserAgent_HEADER"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "sample-metric"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Name = "WAF-SAMPLE"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "sample-metric"
    sampled_requests_enabled   = false
  }
}
