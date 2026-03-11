resource "aws_lambda_function" "lambda_function" {

  for_each = { for function_name, function in var.functions : function_name => function }

  function_name                  = "${var.environment}-${each.value.name}-${var.brand}"
  runtime                        = each.value.package_type == "Zip" ? each.value.runtime : null
  handler                        = each.value.package_type == "Zip" ? each.value.handler : null
  layers                         = each.value.package_type == "Zip" ? each.value.layers : null
  package_type                   = each.value.package_type
  memory_size                    = each.value.memory_size
  timeout                        = each.value.timeout
  reserved_concurrent_executions = each.value.reserved_concurrency
  role                           = "arn:aws:iam::${local.account_id}:role/${coalesce(each.value.role_name, aws_iam_role.lambda_function[each.key].name)}"

  source_code_hash = coalesce(
    each.value.source_code_hash,
    each.value.package_type == "Zip" && each.value.filename != null ? filebase64sha256(each.value.filename) : null,
    each.value.package_type == "S3" && each.value.s3_key != null ? filebase64sha256(each.value.s3_key) : null
  )
  filename  = each.value.package_type == "Zip" ? each.value.filename : null
  image_uri = each.value.package_type == "Image" ? each.value.image_uri : null

  environment {
    variables = each.value.environment_variables
  }

  vpc_config {
    security_group_ids = flatten([each.value.security_group_ids, var.lambda_security_group])
    subnet_ids         = var.private_subnets
  }

  architectures = each.value.architectures

  tags = merge(local.tags, each.value.tags)
}


# Provisioned concurrency (optional)
resource "aws_lambda_provisioned_concurrency_config" "main" {
  for_each                          = { for function_name, function in var.functions : function_name => function if function.provisioned_concurrency != null && function.provisioned_concurrency > 0 }
  function_name                     = aws_lambda_function.lambda_function[each.key].function_name
  provisioned_concurrent_executions = each.value.provisioned_concurrency
  qualifier                         = aws_lambda_function.lambda_function[each.key].version
}
