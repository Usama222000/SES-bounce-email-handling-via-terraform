
output "Dynamo" {
  value = {
    dynamo_arn = aws_dynamodb_table.Usama-dynamodb-table.arn
    table_name = aws_dynamodb_table.Usama-dynamodb-table.id
  }
}