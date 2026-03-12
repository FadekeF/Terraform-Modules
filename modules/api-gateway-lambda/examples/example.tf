# This file has been replaced with numbered examples showing different use cases.
# See the numbered example files (1-basic-single-route.tf, 2-multiple-routes.tf, etc.)
# for comprehensive demonstrations of module capabilities.

# Quick reference - basic usage pattern:
# module "api_gateway" {
#   source = "../"
#
#   service_name      = "my-api"
#   brand             = "company"
#   environment       = "dev"
#   project           = "my-project"
#   github_repository = "https://github.com/example/repo"
#
#   routes = {
#     "my_endpoint" = {
#       route_key            = "GET /example"
#       lambda_function_name = aws_lambda_function.handler.function_name
#       integration_uri      = aws_lambda_function.handler.invoke_arn
#       integration_method   = "POST"
#     }
#   }
#
#   allow_api_gateway_invoke_lambda = true
# }
