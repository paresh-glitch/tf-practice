resource "aws_s3_bucket" "s3" {
  bucket = var.bucket

  tags = {
    Name        = var.bucket
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

