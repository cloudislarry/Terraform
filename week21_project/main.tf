
resource "aws_s3_bucket" "week21-s3-larryjohnson" {
  bucket = "week21-s3-larryjohnson"

  tags = {
    Name        = "week21 S3 bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "week21-s3-larryjohnson" {
  bucket = aws_s3_bucket.week21-s3-larryjohnson.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "week21-s3-larryjohnson_access_block" {
  bucket = aws_s3_bucket.week21-s3-larryjohnson.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
