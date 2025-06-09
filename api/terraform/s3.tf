resource "aws_s3_bucket" "wijha-bucket" {
  bucket_prefix = var.bucket_prefix
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "wijha-bucket-versioning" {
  bucket = aws_s3_bucket.wijha-bucket.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_public_access_block" "wijha-bucket" {
  bucket = aws_s3_bucket.wijha-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
