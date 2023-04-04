resource "aws_dynamodb_table" "Usama-dynamodb-table" {
  name           = "usama-Dynamo"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "MessageId"
  stream_view_type = "NEW_IMAGE"
  stream_enabled   = true
  attribute {
    name = "MessageId"
    type = "S"
  }
  tags = {
   defuse = "2023-01-20"
  }
}
# resource "aws_lambda_event_source_mapping" "example" {
#   event_source_arn  = aws_dynamodb_table.Usama-dynamodb-table.stream_arn
#   function_name     = var.lambda_arn
#   starting_position = "LATEST"
# }