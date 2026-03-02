resource "aws_s3_bucket" "bucket" {
  bucket = "${var.environment}-${var.name}-${var.brand}"

  tags = local.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.existing_kms_key_id != null ? var.existing_kms_key_id : aws_kms_key.bucket.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = ["s3:*"]
        Resource  = "${aws_s3_bucket.bucket.arn}/*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = false
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket" {
  for_each = var.enable_lifecycle_rule ? 1 : 0
  bucket   = aws_s3_bucket.bucket.id

  rule {
    id     = "ExpireObjectsAfter${var.bucket_expiration_days}Days"
    status = "Enabled"

    expiration {
      days = var.bucket_expiration_days
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "bucket" {
  for_each = var.versioning_enabled ? 1 : 0
  bucket   = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}
