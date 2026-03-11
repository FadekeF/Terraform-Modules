resource "aws_lambda_function" "lambda_function" {

  function_name                  = "${var.environment}-${var.function_name}-${var.brand}"
  description                    = var.function_description
  runtime                        = var.package_type == "Zip" ? var.runtime : null
  handler                        = var.package_type == "Zip" ? var.handler : null
  layers                         = var.package_type == "Zip" ? var.layers : null
  package_type                   = var.package_type
  s3_bucket                      = var.package_type == "S3" ? var.s3_bucket : null
  s3_key                         = var.package_type == "S3" ? var.s3_key : null
  image_uri                      = var.package_type == "Image" ? var.image_uri : null
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrency
  role                           = "arn:aws:iam::${local.account_id}:role/${coalesce(var.role_name, aws_iam_role.lambda_function[0].name)}"

  source_code_hash = coalesce(
    var.source_code_hash,
    var.package_type == "Zip" && var.filename != null ? filebase64sha256(var.filename) : null,
    var.package_type == "S3" && var.s3_key != null ? filebase64sha256(var.s3_key) : null
  )
  filename = var.package_type == "Zip" ? var.filename : null

  environment {
    variables = var.environment_variables
  }

  vpc_config {
    security_group_ids = flatten([var.security_group_ids, var.lambda_security_group])
    subnet_ids         = var.private_subnets
  }

  architectures = var.architectures

  tags = merge(local.tags, var.tags)
}


# Provisioned concurrency (optional)
resource "aws_lambda_provisioned_concurrency_config" "main" {
  count                             = var.provisioned_concurrency != null && var.provisioned_concurrency > 0 ? 1 : 0
  function_name                     = aws_lambda_function.lambda_function.function_name
  provisioned_concurrent_executions = var.provisioned_concurrency
  qualifier                         = aws_lambda_function.lambda_function.version
}
