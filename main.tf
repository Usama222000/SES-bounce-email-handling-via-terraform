 
module "SES" {
  source = "./modules/ses"
  SES = var.SES
  sns_arn =  module.SNS.SNS.sns_arn
 }
module "SNS" {
  source = "./modules/sns"
  ses_arn = module.SES.SES.ses_arn
  lambda_arn=module.Lambda.LAMBDA.lambda_arn
 }
module "Lambda" {
  source = "./modules/lambdas"
  Lambda= var.Lambda
  sns_arn = module.SNS.SNS.sns_arn
  dynamo_arn = module.DynamoDB.Dynamo.dynamo_arn
  table_name = module.DynamoDB.Dynamo.table_name
 }
 module "DynamoDB" {
  source = "./modules/Dynamo"
  # lambda_arn=module.Lambda.LAMBDA.lambda_arn
 }
