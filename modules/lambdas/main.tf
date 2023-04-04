provider "archive" {}
data "archive_file" "zip" {
  type        = "zip"
  source_file = "./lambda-src/index.mjs"
  output_path = "index.zip"
}
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role_policy" "my_inline_policy" {
  name = "Dynamo_access"
  role = aws_iam_role.iam_for_lambda.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1428341300017",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:UpdateItem"
            ],
            "Effect": "Allow",
            "Resource": var.dynamo_arn
        },
        {
            "Sid": "",
            "Resource": "*",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Effect": "Allow"
        }
    ]
  })
}
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}
resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.usama-lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_arn
}
resource "aws_lambda_function" "usama-lambda" {
  function_name = "usama-ses-lambda"
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role    = aws_iam_role.iam_for_lambda.arn
  handler = "index.lambda_handler"
  runtime = "nodejs18.x"
  environment {
    variables = {
      table_name = var.table_name
      slack_url = var.Lambda.slack_url
    }
  }
}