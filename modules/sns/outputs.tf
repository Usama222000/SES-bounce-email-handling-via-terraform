
output "SNS" {
  value = {
    sns_arn = aws_sns_topic.usama_sns_topic.arn
  }
}