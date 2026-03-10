resource "aws_iam_role" "lambda_function" {
  for_each = { for function_name, function in var.functions : function_name => function }
  name     = "${var.environment}-${each.value.name}-${var.brand}-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = local.account_id
          }
        }
      }
    ]
  })
  tags = local.tags
}


resource "aws_iam_role_policy_attachment" "lambda_function" {
  for_each   = aws_iam_role.lambda_function
  role       = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# VPC access policy (if VPC is configured)
resource "aws_iam_role_policy_attachment" "lambda_vpc" {
  count      = var.vpc_config != null ? 1 : 0
  role       = aws_iam_role.lambda_function[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy" "lambda_function" {
  for_each = aws_iam_role.lambda_function
  name     = "${var.environment}-${each.value.name}-s3-policy"
  role     = each.value.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3Access"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3-object-lambda:GetObject",
          "s3-object-lambda:WriteGetObjectResponse",
          "s3-object-lambda:ListBucket"

        ]
        Resource = "*"
      },
      {
        Sid    = "S3DeleteAccess"
        Effect = "Allow"
        Action = [
          "s3:DeleteObject"
        ]
        Resource = "*"
      },
      {
        Sid    = "S3ListAccess"
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
          "s3:ListBucket"
        ]
        Resource = "*"
      },
      {
        Sid    = "S3KMSAccess"
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:ReEncrypt*"
        ]
        Resource = "*"
      }
    ]
  })
}
