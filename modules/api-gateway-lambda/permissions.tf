resource "aws_lambda_permission" "this" {
  for_each      = var.allow_api_gateway_invoke_lambda ? var.routes : {}
  statement_id  = "${var.service_name}-${each.key}-apigw-invoke"
  action        = "lambda:InvokeFunction"
  function_name = each.value.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*"
}
