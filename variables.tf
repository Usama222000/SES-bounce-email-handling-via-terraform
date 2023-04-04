variable "VPC_vars" {
  type = object({
   # AWS_REGION = string
    vpc_cidr = string
    ENV = string
    public_subnets = list(string)
    private_subnets = list(string)
    AZS = list(string)
  })
}
variable "web_sg" {
  # type = object({
  #   cidr = map(list(string))
  #   ports = list(number)
  #   name_prefix = string
  #   max_alb_rules_limit = number
  #   max_security_groups_limit = number
  #   tags = object(map)
  # })
}
variable "SES" {
  type = object({
    email = string
  })
}
# variable "SNS" {
#   type = object({
#     ses-arn = string
#   })
# }
variable "Lambda" {
  type = object({
    slack_url = string
  })
}

