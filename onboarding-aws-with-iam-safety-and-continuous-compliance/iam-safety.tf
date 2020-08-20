# IAM SAFETY ONBOARDING

# IAM Safety policy
resource "aws_iam_policy" "dome9_iam_safety_policy" {
  count = var.connect_iam_safety == true ? 1 : 0
  name        = "CloudGuardDome9IAMSafetyPolicy"
  description = "dome9 policy"
  policy      = data.aws_iam_policy_document.dome9_iam_safety_policy[count.index].json
}

data "aws_iam_policy_document" "dome9_iam_safety_policy" {
  count = var.connect_iam_safety == true ? 1 : 0
  statement {
    sid = "Dome9IamSafe"

    effect = "Deny"

    actions = [
      "autoscaling:Delete*",
      "autoscaling:Terminate*",
      "autoscaling:Update*",
      "cloudfront:DeleteDistribution",
      "cloudfront:DeleteStreamingDistribution",
      "cloudhsm:Create*",
      "cloudhsm:Delete*",
      "cloudhsm:Modify*",
      "directconnect:AllocatePrivateVirtualInterface",
      "directconnect:AllocatePublicVirtualInterface",
      "directconnect:Create*",
      "directconnect:Delete*",
      "ds:Connect*",
      "ds:CreateComputer",
      "ds:CreateDirectory",
      "ds:Delete*",
      "ds:RestoreFromSnapshot",
      "ds:Update*",
      "dynamodb:DeleteTable",
      "dynamodb:UpdateTable",
      "ec2:CreateNetworkAcl",
      "ec2:CreateNetworkAclEntry",
      "ec2:CreateNetworkInterface",
      "ec2:CreateSecurityGroup",
      "ec2:Delete*",
      "ec2:DetachInternetGateway",
      "ec2:DetachNetworkInterface",
      "ec2:DetachVolume",
      "ec2:DisassociateAddress",
      "ec2:GetPasswordData",
      "ec2:ImportKeyPair",
      "ec2:ReplaceNetworkAclAssociation",
      "ec2:ReplaceNetworkAclEntry",
      "ec2:ReplaceRoute",
      "ec2:ReplaceRouteTableAssociation",
      "ec2:Stop*",
      "ec2:Terminate*",
      "ecs:Delete*",
      "elasticache:Delete*",
      "elasticache:Modify*",
      "elasticache:Purchase*",
      "elasticache:RebootCacheCluster",
      "elasticache:ResetCacheParameterGroup",
      "elasticache:RevokeCacheSecurityGroupIngress",
      "elasticbeanstalk:Delete*",
      "elasticbeanstalk:Terminate*",
      "elasticfilesystem:CreateTags",
      "elasticfilesystem:Delete*",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancerListeners",
      "elasticloadbalancing:CreateLoadBalancerPolicy",
      "elasticloadbalancing:Delete*",
      "elasticloadbalancing:Delete*",
      "elasticloadbalancing:Deregister*",
      "elasticloadbalancing:Detach*",
      "elasticloadbalancing:Disable*",
      "elasticloadbalancing:Enable*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "glacier:Add*",
      "glacier:Delete*",
      "glacier:Re*",
      "inspector:Set*",
      "kms:CreateKey",
      "kms:Decrypt*",
      "kms:Disable*",
      "kms:EnableKey",
      "lambda:Add*",
      "lambda:CreateEventSourceMapping",
      "lambda:CreateFunction",
      "lambda:Delete*",
      "lambda:Re*",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
      "rds:AddTagsToResource",
      "rds:DeleteDBInstance",
      "rds:DeleteDBSecurityGroup",
      "rds:DeleteDBSnapshot",
      "rds:DeleteEventSubscription",
      "rds:ModifyDBInstance",
      "rds:ModifyEventSubscription",
      "rds:Purchase*",
      "rds:RebootDBInstance",
      "rds:RemoveTagsFromResource",
      "rds:RestoreDBClusterFromSnapshot",
      "rds:RestoreDBClusterToPointInTime",
      "rds:RestoreDBInstanceFromDBSnapshot",
      "rds:RestoreDBInstanceToPointInTime",
      "rds:RevokeDBSecurityGroupIngress",
      "redshift:Authorize*",
      "redshift:CreateTags",
      "redshift:DeleteCluster",
      "redshift:DeleteClusterSnapshot",
      "redshift:DeleteClusterSubnetGroup",
      "redshift:DeleteEventSubscription",
      "redshift:DeleteHsmClientCertificate",
      "redshift:DeleteHsmConfiguration",
      "redshift:DeleteTags",
      "redshift:ModifyCluster",
      "redshift:ModifyEventSubscription",
      "redshift:Purchase*",
      "redshift:RebootCluster",
      "redshift:Rotate*",
      "route53:Associate*",
      "route53:Change*",
      "route53:CreateHostedZone",
      "route53:CreateReusableDelegationSet",
      "route53:Delete*",
      "route53:Disable*",
      "route53:Disassociate*",
      "route53:Enable*",
      "route53domains:Delete*",
      "route53domains:Disable*",
      "route53domains:Enable*",
      "route53domains:Transfer*",
      "route53domains:UpdateDomainContact",
      "route53domains:UpdateDomainNameservers",
      "route53domains:UpdateTagsForDomain",
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:DeleteBucketWebsite",
      "s3:PutBucketPolicy",
      "sdb:BatchDeleteAttributes",
      "sdb:Create*",
      "sdb:Delete*",
      "ssm:CreateAssociation",
      "ssm:CreateDocument",
      "ssm:Delete*",
      "storagegateway:Activate*",
      "storagegateway:DeleteGateway",
      "storagegateway:DeleteSnapshotSchedule",
      "storagegateway:DeleteTape",
      "storagegateway:DeleteTapeArchive",
      "storagegateway:DeleteVolume",
      "storagegateway:RetrieveTapeArchive",
      "storagegateway:Shutdown*"
    ]

    resources = ["*"]
  }

  statement {
    sid = "Dome9IamSafeMandatory"

    effect = "Deny"

    actions = [
      "iam:Add*",
      "iam:Attach*",
      "iam:Create*",
      "iam:Deactivate*",
      "iam:Delete*",
      "iam:Detach*",
      "iam:Put*",
      "iam:Remove*",
      "iam:Set*",
      "iam:Update*",
      "iam:Upload*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_group" "iam_safety_group" {
  count = var.connect_iam_safety == true ? 1 : 0
  name = "Dome9-Restricted-Policy"
}

resource "aws_iam_group_policy_attachment" "iam_safety_group_policy_attachment" {
  count = var.connect_iam_safety == true ? 1 : 0
  group      = aws_iam_group.iam_safety_group[count.index].name
  policy_arn = aws_iam_policy.dome9_iam_safety_policy[count.index].arn
}

resource "dome9_attach_iam_safe" "self" {
  count = var.connect_iam_safety == true ? 1 : 0
  aws_cloud_account_id = dome9_cloudaccount_aws.self.id
  aws_group_arn        = aws_iam_group.iam_safety_group[count.index].arn
  aws_policy_arn       = aws_iam_policy.dome9_iam_safety_policy[count.index].arn
}
