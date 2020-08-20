resource "dome9_continuous_compliance_policy" "sample_policy" {
  cloud_account_id    = dome9_cloudaccount_aws.self.id
  external_account_id = dome9_cloudaccount_aws.self.external_account_number
  bundle_id           = var.bundle_id
  cloud_account_type  = "Aws"
  notification_ids    = [dome9_continuous_compliance_notification.sample_notification.id]
}

resource "dome9_continuous_compliance_notification" "sample_notification" {
  name           = "demo-notification"
  description    = "DESCRIPTION"
  alerts_console = true

  change_detection {
    email_sending_state                = "Enabled"
    email_per_finding_sending_state    = "Disabled"
    sns_sending_state                  = "Disabled"
    external_ticket_creating_state     = "Disabled"
    aws_security_hub_integration_state = "Disabled"
    webhook_integration_state          = "Disabled"

    email_data {
      recipients = ["erezwe@checkpoint.com"]
    }
  }
}

