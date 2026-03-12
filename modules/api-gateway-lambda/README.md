<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_api.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_deployment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_deployment) | resource |
| [aws_apigatewayv2_integration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_stage.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_api_gateway_invoke_lambda"></a> [allow\_api\_gateway\_invoke\_lambda](#input\_allow\_api\_gateway\_invoke\_lambda) | Whether to create permissions allowing API Gateway to invoke Lambda functions. Set to false if permissions are managed outside of this module. | `bool` | `false` | no |
| <a name="input_api_description"></a> [api\_description](#input\_api\_description) | Optional API description. | `string` | `null` | no |
| <a name="input_auto_deploy"></a> [auto\_deploy](#input\_auto\_deploy) | Whether to automatically deploy updates to the stage. | `bool` | `true` | no |
| <a name="input_brand"></a> [brand](#input\_brand) | Identifier for BlueLightCard Brands e.g BLC-UK, BLC-DDS, or BLC-AU. Used in naming and tagging to differentiate resources across brands. | `string` | n/a | yes |
| <a name="input_cors_configuration"></a> [cors\_configuration](#input\_cors\_configuration) | Optional CORS configuration for HTTP API. | <pre>object({<br/>    allow_credentials = optional(bool, null)<br/>    allow_headers     = optional(list(string), null)<br/>    allow_methods     = optional(list(string), null)<br/>    allow_origins     = optional(list(string), null)<br/>    expose_headers    = optional(list(string), null)<br/>    max_age           = optional(number, null)<br/>  })</pre> | `{}` | no |
| <a name="input_create_deployment"></a> [create\_deployment](#input\_create\_deployment) | Whether to create explicit API Gateway deployments. Recommended when auto\_deploy is false. | `bool` | `true` | no |
| <a name="input_enable_access_logs"></a> [enable\_access\_logs](#input\_enable\_access\_logs) | Whether to create and attach a CloudWatch access log group. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment identifier (for example: dev, stage, prod). | `string` | n/a | yes |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Github repository API Gateway is created in | `string` | n/a | yes |
| <a name="input_integration_type"></a> [integration\_type](#input\_integration\_type) | Optional Description for explicit API Gateway deployments. | `string` | `"AWS_PROXY"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | CloudWatch log retention in days. | `number` | `30` | no |
| <a name="input_project"></a> [project](#input\_project) | Project or workload identifier used in naming and Terraform Cloud workspace standardization. | `string` | n/a | yes |
| <a name="input_protocol_type"></a> [protocol\_type](#input\_protocol\_type) | Protocol type for API Gateway v2 API resource. | `string` | `"HTTP"` | no |
| <a name="input_route_selection_expression"></a> [route\_selection\_expression](#input\_route\_selection\_expression) | Route selection expression for WebSocket APIs. | `string` | `"$request.body.action"` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | Map of API routes with their Lambda integration configuration | <pre>map(object({<br/>    route_key            = string<br/>    lambda_function_name = string<br/>    integration_uri      = string<br/>    integration_method   = optional(string, "POST")<br/><br/>    authorization_type   = optional(string)<br/>    authorizer_id        = optional(string)<br/>    authorization_scopes = optional(string)<br/>    api_key_required     = optional(bool, false)<br/>    operation_name       = optional(string)<br/>    request_models       = optional(map(string))<br/><br/>    connection_type           = optional(string, "INTERNET")<br/>    content_handling_strategy = optional(string)<br/>    description               = optional(string)<br/>    passthrough_behavior      = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Base name for the API Gateway. Used in combination with environment and brand for resource naming. | `string` | n/a | yes |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | Stage name to create. Use '$default' for an auto-deployed default stage. | `string` | `"$default"` | no |
| <a name="input_stage_variables"></a> [stage\_variables](#input\_stage\_variables) | Map of stage variables. | `map(string)` | `{}` | no |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Terraform Cloud workspace name. Defaults to the active terraform.workspace. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_arn"></a> [api\_arn](#output\_api\_arn) | ARN of the API Gateway API. |
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | Invoke endpoint for the API. |
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | ID of the API Gateway API. |
| <a name="output_api_name"></a> [api\_name](#output\_api\_name) | Name of the API Gateway API. |
| <a name="output_deployment_id"></a> [deployment\_id](#output\_deployment\_id) | ID of the explicit deployment when create\_deployment is enabled and auto\_deploy is false |
| <a name="output_effective_workspace_name"></a> [effective\_workspace\_name](#output\_effective\_workspace\_name) | Effective Terraform workspace name used by this module. |
| <a name="output_integration_ids"></a> [integration\_ids](#output\_integration\_ids) | Map of route keys to integration IDs |
| <a name="output_route_ids"></a> [route\_ids](#output\_route\_ids) | Map of route keys to route IDs |
| <a name="output_stage_id"></a> [stage\_id](#output\_stage\_id) | ID of the deployed stage. |
| <a name="output_stage_name"></a> [stage\_name](#output\_stage\_name) | Name of the deployed stage. |
| <a name="output_tags"></a> [tags](#output\_tags) | Final merged tags applied to resources. |
<!-- END_TF_DOCS -->
