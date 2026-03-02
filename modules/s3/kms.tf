resource "aws_kms_key" "bucket" {
  description = "KMS key for encrypting S3 bucket objects"
  #   key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = var.enable_key_rotation
  deletion_window_in_days = 20
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${local.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      #   {
      #     Sid    = "Allow administration of the key"
      #     Effect = "Allow"
      #     Principal = {
      #       AWS = "arn:aws:iam::${local.account_id}:user/Alice"
      #     },
      #     Action = [
      #       "kms:ReplicateKey",
      #       "kms:Create*",
      #       "kms:Describe*",
      #       "kms:Enable*",
      #       "kms:List*",
      #       "kms:Put*",
      #       "kms:Update*",
      #       "kms:Revoke*",
      #       "kms:Disable*",
      #       "kms:Get*",
      #       "kms:Delete*",
      #       "kms:ScheduleKeyDeletion",
      #       "kms:CancelKeyDeletion"
      #     ],
      #     Resource = "*"
      #   },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        },
        Action = [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext"
        ],
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "s3.${local.region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = local.tags
}

resource "aws_kms_alias" "bucket" {
  name          = "alias/${var.environment}-${var.name}-${var.brand}"
  target_key_id = aws_kms_key.bucket.id
}
