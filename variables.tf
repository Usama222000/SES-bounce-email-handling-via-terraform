variable "VPC_vars" {
  type = object({
    vpc_cidr = string
    ENV = string
    public_subnets = list(string)
    private_subnets = list(string)
    AZS = list(string)
  })
}
variable "web_sg" {
}
variable "SES" {
  type = object({
    email = string
  })
}

variable "Lambda" {
  type = object({
    slack_url = string
  })
}

