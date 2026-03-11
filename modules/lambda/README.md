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
| [aws_cloudwatch_log_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_provisioned_concurrency_config.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_provisioned_concurrency_config) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Lambda function architectures | `list(string)` | <pre>[<br/>  "x86_64"<br/>]</pre> | no |
| <a name="input_brand"></a> [brand](#input\_brand) | Identifier for BlueLightCard Brands e.g BLC-UK, BLC-DDS, or BLC-AU. Used in naming and tagging to differentiate resources across brands. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment identifier (for example: dev, stage, prod). | `string` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables for the Lambda function | `map(string)` | `{}` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Path to the zip file for Lambda function code (required if package\_type is Zip) | `string` | `null` | no |
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description of the Lambda function | `string` | `null` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of the Lambda function | `string` | n/a | yes |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Optional GitHub repository URL to include in tags for traceability. | `string` | `null` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Lambda function handler | `string` | `"index.handler"` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | ECR image URI for Lambda function (required if package\_type is Image) | `string` | `null` | no |
| <a name="input_lambda_security_group"></a> [lambda\_security\_group](#input\_lambda\_security\_group) | Security group ID to associate with Lambda functions for VPC access. Optional if Lambda functions do not require VPC access. | `list(string)` | `[]` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda layer ARNs to attach to the function | `list(string)` | `[]` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Number of days to retain CloudWatch Logs for Lambda functions. Set to 0 for infinite retention. | `number` | `14` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Memory allocation in MB for the Lambda function | `number` | `512` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | Lambda function package type (Zip or Image) | `string` | `"Zip"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnet IDs for Lambda functions that require VPC access. Optional if Lambda functions do not require VPC access. | `list(string)` | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | Project or workload identifier used in naming and Terraform Cloud workspace standardization. | `string` | n/a | yes |
| <a name="input_provisioned_concurrency"></a> [provisioned\_concurrency](#input\_provisioned\_concurrency) | Provisioned concurrent executions for the Lambda function | `number` | `null` | no |
| <a name="input_reserved_concurrency"></a> [reserved\_concurrency](#input\_reserved\_concurrency) | Reserved concurrent executions for the Lambda function | `number` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IAM role name for the Lambda function. If null, a new role will be created with basic Lambda execution permissions | `string` | `null` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda function runtime | `string` | `"nodejs20.x"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket containing the Lambda function code | `string` | `null` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | S3 key for the Lambda function code | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs for Lambda function when using VPC | `list(string)` | `[]` | no |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | Hash of the source code to force updates | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the Lambda function | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout in seconds for the Lambda function | `number` | `60` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | VPC configuration for Lambda functions. If null, Lambda functions will not be associated with a VPC. | <pre>object({<br/>    security_group_ids = list(string)<br/>    subnet_ids         = list(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | ARN of the Lambda function. |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | Name of the Lambda function. |
| <a name="output_lambda_function_qualified_arn"></a> [lambda\_function\_qualified\_arn](#output\_lambda\_function\_qualified\_arn) | Qualified ARN of the Lambda function (including version). |
| <a name="output_lambda_function_role_arn"></a> [lambda\_function\_role\_arn](#output\_lambda\_function\_role\_arn) | ARN of the Lambda function execution role. |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | Version of the Lambda function. |
| <a name="output_lambda_function_vpc_config"></a> [lambda\_function\_vpc\_config](#output\_lambda\_function\_vpc\_config) | VPC configuration of the Lambda function (if applicable). |
<!-- END_TF_DOCS -->
