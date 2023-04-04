
output "SES" {
  value = {
    ses_arn = aws_ses_email_identity.SES.arn
  }
}