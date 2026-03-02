output "api_id" {
  description = "ID of the API Gateway API."
  value       = aws_apigatewayv2_api.this.id
}
output "api_arn" {
  description = "ARN of the API Gateway API."
  value       = aws_apigatewayv2_api.this.arn
}
output "api_name" {
  description = "Name of the API Gateway API."
  value       = aws_apigatewayv2_api.this.name
}
output "api_endpoint" {
  description = "Invoke endpoint for the API."
  value       = aws_apigatewayv2_api.this.api_endpoint
}
output "stage_id" {
  description = "ID of the deployed stage."
  value       = aws_apigatewayv2_stage.this.id
}
output "stage_name" {
  description = "Name of the deployed stage."
  value       = aws_apigatewayv2_stage.this.name
}
output "integration_ids" {
  description = "Map of route keys to integration IDs"
  value       = { for key, integration in aws_apigatewayv2_integration.this : key => integration.id }
}
output "route_ids" {
  description = "Map of route keys to route IDs"
  value       = { for key, route in aws_apigatewayv2_route.this : key => route.id }
}
output "deployment_id" {
  description = "ID of the explicit deployment when create_deployment is enabled and auto_deploy is false"
  value       = { for key, route in aws_apigatewayv2_route.this : key => route.id }
}
# output "standardized_name" {
#   description = "Standardized resource name calculated by the module."
#   value       = local.resource_name
# }
# output "standardized_workspace_name" {
#   description = "Standardized Terraform Cloud workspace name pattern for this module."
#   value       = local.standardized_workspace_name
# }
output "effective_workspace_name" {
  description = "Effective Terraform workspace name used by this module."
  value       = local.resolved_workspace_name
}
output "tags" {
  description = "Final merged tags applied to resources."
  value       = local.tags
}
