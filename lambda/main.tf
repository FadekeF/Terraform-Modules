# # IAM role for Lambda execution
# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "example" {
#   name               = "lambda_execution_role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# # Package the Lambda function code
# data "archive_file" "example" {
#   type        = "zip"
#   source_file = "${path.module}/lambda/index.js"
#   output_path = "${path.module}/lambda/function.zip"
# }

# # Lambda function
# resource "aws_lambda_function" "example" {
#   filename      = data.archive_file.example.output_path
#   function_name = "example_lambda_function"
#   role          = aws_iam_role.example.arn
#   handler       = "index.handler"
#   code_sha256   = data.archive_file.example.output_base64sha256

#   runtime = "nodejs20.x"

#   environment {
#     variables = {
#       ENVIRONMENT = "production"
#       LOG_LEVEL   = "info"
#     }
#   }

#   tags = {
#     Environment = "production"
#     Application = "example"
#   }
# }

resource "aws_lambda_function" "lambda_function" {
  for_each = { for function_name, function in var.functions : function_name => function }

  function_name                  = each.value.name
  runtime                        = each.value.package_type == "Zip" ? each.value.runtime : null
  handler                        = each.value.package_type == "Zip" ? each.value.handler : null
  layers                         = each.value.package_type == "Zip" ? each.value.layers : null
  package_type                   = each.value.package_type
  memory_size                    = each.value.memory_size
  timeout                        = each.value.timeout
  reserved_concurrent_executions = each.value.reserved_concurrency
  role                           = "arn:aws:iam::${local.account_id}:role/${coalesce(each.value.role_name, aws_iam_role.lambda_function.name)}"

  # source_code_hash = each.value.package_type == "Zip" ? data.archive_file[function_name].output_base64sha256 : null
  # filename         = each.value.package_type == "Zip" ? data.archive_file[function_name].output_path : null
  source_code_hash = each.value.package_type == "Zip" && each.value.filename != null ? filebase64sha256(each.value.filename) : each.value.package_type == "S3" && each.value.s3_key != null ? filebase64sha256(each.value.s3_key) : null
  filename         = each.value.package_type == "Zip" ? each.value.filename : null
  image_uri        = each.value.package_type == "Image" ? each.value.image_uri : null

  environment {
    variables = each.value.environment_variables
  }

  vpc_config {
    security_group_ids = flatten([each.value.security_group_ids, var.lambda_security_group])
    subnet_ids         = var.private_subnets
  }

  architectures = each.value.architectures
}
