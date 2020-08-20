# IAM read only policy
resource "aws_iam_policy" "dome9_read_only_policy" {
  name        = "cloudguard-dome9-readonly-policy"
  description = "dome9 policy"
  policy      = data.aws_iam_policy_document.dome9_read_only_policy.json
}

data "aws_iam_policy_document" "dome9_read_only_policy" {
  statement {
    sid = "CloudGuardDome9ReadOnly"

    actions = [
      "cloudtrail:LookupEvents",
      "dynamodb:DescribeTable",
      "dynamodb:ListTagsOfResource",
      "elasticfilesystem:Describe*",
      "elasticache:ListTagsForResource",
      "es:ListTags",
      "firehose:Describe*",
      "firehose:List*",
      "guardduty:Get*",
      "guardduty:List*",
      "kinesis:List*",
      "kinesis:Describe*",
      "kinesisvideo:Describe*",
      "kinesisvideo:List*",
      "logs:Describe*",
      "logs:Get*",
      "logs:FilterLogEvents",
      "lambda:List*",
      "s3:List*",
      "sns:ListSubscriptions",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTagsForResource",
      "waf-regional:ListResourcesForWebACL"
    ]

    effect = "Allow"

    resources = ["*"]
  }
}
# IAM write policy
resource "aws_iam_policy" "dome9_write_policy" {
  name        = "cloudguard-dome9-write-policy"
  description = "dome9 policy"
  policy      = data.aws_iam_policy_document.dome9_write_policy.json
}

data "aws_iam_policy_document" "dome9_write_policy" {
  statement {
    sid = "CloudGuardDome9Write"

    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
      "ec2:DeleteSecurityGroup",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:CreateTags",
      "ec2:DeleteTags"
    ]

    effect = "Allow"

    resources = ["*"]
  }
}

# IAM role
resource "aws_iam_role" "dome9_integration_role" {
  name = "CloudGuardDome9ConnectRole"
  assume_role_policy = data.aws_iam_policy_document.dome9_integration_role_assume_role_policy.json
}

data "aws_iam_policy_document" "dome9_integration_role_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      identifiers = ["arn:aws:iam::634729597623:root"]
      type = "AWS"
    }

    condition {
      test = "StringEquals"
      values = [random_string.trust_secret.result]
      variable = "sts:ExternalId"
    }
  }
}

# IAM role policies attachment
resource "aws_iam_role_policy_attachment" "attach_dome9_policies" {
  count      = length(local.policies)
  role       = aws_iam_role.dome9_integration_role.name
  policy_arn = element(local.policies, count.index)
}

# Waiter for policies to be attached
# Due to asynchronious response from aws for policy attachments, we must wait for those attachments to be made or else an error will be received from Dome9 (missing permissions)
resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 10"
  }
  triggers = {
    "before" = aws_iam_role.dome9_integration_role.arn
  }
}

# Dome9 onboarding
resource "dome9_cloudaccount_aws" "self" {
  depends_on = [null_resource.delay]
  name       = "Erez Weinstein's AWS account"
  credentials {
    arn    = aws_iam_role.dome9_integration_role.arn
    secret = random_string.trust_secret.result
    type   = "RoleBased"
  }
  net_sec {
    regions {
      new_group_behavior = "FullManage"
      region             = "us_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_west_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_southeast_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_northeast_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_west_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "sa_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_southeast_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_central_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_northeast_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_east_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ca_central_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_3"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_north_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "me_south_1"
    }
  }
}

resource "random_string" "trust_secret" {
  length           = 16
  special          = false
  override_special = "/@£$"
}
