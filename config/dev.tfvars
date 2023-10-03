# VPC  
 VPC_vars = {
    vpc_cidr = "10.0.0.0/16" 
    ENV = "" 
    public_subnets =  ["10.0.1.0/24", "10.0.3.0/24"]
    private_subnets = ["10.0.2.0/24", "10.0.4.0/24", "10.0.5.0/24"]
    AZS = ["us-east-2a", "us-east-2b"] 
  }

  web_sg = [
      {
      name_prefix = "web_sg"
      max_alb_rules_limit = 50
      max_security_groups_limit = 5
      cidr = {
          "80"           = [ "0.0.0.0/0"]
          "8080"           = [ "0.0.0.0/0"]
          "3100"           = [ "0.0.0.0/0"]
          "443"           =[ "0.0.0.0/0"]
          "22"    = [ "0.0.0.0/0"]

      }
      ports = [80, 443, 22]
      tags = { 
        Name = "Usama-web-sg"
        defuse = "2023-01-13"
      }
    }
  ]
  SES = {
    email="xyz@gmail.com"
  }
  Lambda = {
    slack_url = ""#webhook url
  }
