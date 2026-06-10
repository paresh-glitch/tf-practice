output "bucket_name" {
  value = aws_s3_bucket.s3.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.basic-dynamodb-table.name
}

output "bucket_arn" {
  value = aws_s3_bucket.s3.arn
}
