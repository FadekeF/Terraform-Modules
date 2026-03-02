resource "aws_cloudwatch_log_group" "this" {
  count             = var.enable_access_logs ? 1 : 0
  name              = "/aws/apigateway/${var.environment}/${aws_apigatewayv2_api.this.name}"
  retention_in_days = var.log_retention_in_days
  tags              = local.tags
}
