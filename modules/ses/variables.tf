variable "SES" {
  type = object({
    email = string
  })
}
variable "sns_arn" {
  type=string
}