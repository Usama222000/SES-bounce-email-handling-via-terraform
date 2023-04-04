resource "aws_ses_email_identity" "SES" {
  email = var.SES.email
}
resource "aws_ses_identity_notification_topic" "bounce_notifications" {
  topic_arn         = var.sns_arn
  notification_type = "Bounce"
  identity          = aws_ses_email_identity.SES.id
}
resource "aws_ses_identity_policy" "ses_plicy" {
  identity = aws_ses_email_identity.SES.arn
  name     = "usama-ses-policy"
  policy   = data.aws_iam_policy_document.my_custom_sns_policy_document.json
}
data "aws_iam_policy_document" "my_custom_sns_policy_document" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
    "ses:SendEmail",
    "ses:SendRawEmail",
    "ses:SendTemplatedEmail",
    "ses:SendBulkTemplatedEmail"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
    aws_ses_email_identity.SES.arn,
    ]

    sid = "__default_statement_ID"
  }
}
resource "aws_cloudwatch_metric_alarm" "foobar5" {
  alarm_name                = "usama-new-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "Reputation.BounceRate"
  namespace                 = "AWS/SES"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "0.055"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  insufficient_data_actions = []
  dimensions = {
    Domain = aws_ses_email_identity.SES.email
  }
}