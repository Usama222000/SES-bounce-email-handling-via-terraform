variable "dynamo_arn" {
  type = string
}
variable "table_name" {
  type = string
}
variable "sns_arn" {
  type = string
}
variable "Lambda" {
  type = object({
    slack_url = string
  })
}
