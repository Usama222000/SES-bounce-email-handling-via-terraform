resource "aws_sns_topic" "usama_sns_topic" {
  name = "usama-sns-topic"
}

resource "aws_sns_topic_policy" "usama_topic_policy" {
  arn = aws_sns_topic.usama_sns_topic.arn
  policy = data.aws_iam_policy_document.my_custom_sns_policy_document.json
}
resource "aws_sns_topic_subscription" "user_updates_lampda_target" {
  topic_arn = aws_sns_topic.usama_sns_topic.arn
  protocol  = "lambda"
  endpoint  = var.lambda_arn
}
data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "my_custom_sns_policy_document" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
     aws_sns_topic.usama_sns_topic.arn,
    ]

    sid = "__default_statement_ID"
  }
}