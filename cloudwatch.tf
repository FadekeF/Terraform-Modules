resource "aws_cloudwatch_log_group" "lambda" {
  for_each          = aws_lambda_function.lambda_function
  name              = "/aws/lambda/${each.value.function_name}"
  retention_in_days = var.log_retention_days
}
