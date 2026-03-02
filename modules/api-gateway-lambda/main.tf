resource "aws_apigatewayv2_api" "this" {
  name                       = "${var.environment}-${var.name}-${var.brand}"
  protocol_type              = var.protocol_type
  description                = var.api_description
  route_selection_expression = var.protocol_type == "WEBSOCKET" ? var.route_selection_expression : null
  dynamic "cors_configuration" {
    for_each = var.protocol_type == "HTTP" && var.cors_configuration != null ? [var.cors_configuration] : []
    content {
      allow_credentials = try(cors_configuration.value.allow_credentials, null)
      allow_headers     = try(cors_configuration.value.allow_headers, null)
      allow_methods     = try(cors_configuration.value.allow_methods, null)
      allow_origins     = try(cors_configuration.value.allow_origins, null)
      expose_headers    = try(cors_configuration.value.expose_headers, null)
      max_age           = try(cors_configuration.value.max_age, null)
    }
  }

  tags = local.tags

  # lifecycle {
  #   precondition {
  #     condition     = !var.enforce_workspace_standard || local.resolved_workspace_name == local.standardized_workspace_name
  #     error_message = "Workspace naming does not follow standard '<organization>-<project>-<environment>'."
  #   }
  # }
}

resource "aws_apigatewayv2_integration" "this" {
  for_each         = var.routes
  api_id           = aws_apigatewayv2_api.this.id
  integration_type = var.integration_type

  connection_type           = each.value.connection_type           //"INTERNET"
  content_handling_strategy = each.value.content_handling_strategy //"CONVERT_TO_TEXT"
  description               = each.value.description
  integration_method        = each.value.integration_method   //"POST"
  integration_uri           = each.value.integration_uri      //"arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_function.arn}/invocations"
  passthrough_behavior      = each.value.passthrough_behavior //"WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "this" {
  for_each  = var.routes
  api_id    = aws_apigatewayv2_api.this.id
  route_key = each.value.route_key //"ANY /{proxy+}"
  target    = each.value.target    //"integrations/${aws_apigatewayv2_integration.this.id}"

  authorization_type   = each.value.authorization_type
  authorization_scopes = each.value.authorization_scopes
  authorizer_id        = each.value.authorizer_id
  api_key_required     = each.value.api_key_required
  operation_name       = each.value.operation_name
  request_models       = each.value.request_models
  # request_parameter = each.value.request_parameter
}

resource "aws_apigatewayv2_stage" "this" {
  api_id          = aws_apigatewayv2_api.this.id
  name            = var.stage_name
  auto_deploy     = var.auto_deploy
  tags            = local.tags
  stage_variables = var.stage_variables
  deployment_id   = local.create_explicit_deployment ? aws_apigatewayv2_deployment.this[0].id : null

  dynamic "access_log_settings" {
    for_each = var.enable_access_logs ? [1] : []

    content {
      destination_arn = aws_cloudwatch_log_group.this[0].arn
      format = jsonencode({
        requestId      = "$context.requestId"
        ip             = "$context.identity.sourceIp"
        requestTime    = "$context.requestTime"
        httpMethod     = "$context.httpMethod"
        routeKey       = "$context.routeKey"
        status         = "$context.status"
        protocol       = "$context.protocol"
        responseLength = "$context.responseLength"
      })
    }
  }
}

resource "aws_apigatewayv2_deployment" "this" {
  depends_on = [
    aws_apigatewayv2_integration.this,
    aws_apigatewayv2_route.this,
    aws_lambda_permission.this
  ]
  count       = local.create_explicit_deployment ? 1 : 0
  api_id      = aws_apigatewayv2_api.this.id
  description = "this deployment"

  triggers = {
    redeployment = sha1(jsonencode({
      routes          = var.routes
      stage_variables = var.stage_variables
      # custom_triggers = var.custom_triggers

      # aws_apigatewayv2_integration.this),
      # jsonencode(aws_apigatewayv2_route.this),
    }))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "this" {
  for_each      = var.routes
  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "MyDemoFunction"
  principal     = "apigateway.amazonaws.com"

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  source_arn = "${aws_apigatewayv2_api.this.execution_arn}/*"
}
