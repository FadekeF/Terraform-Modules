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
| [aws_iam_role.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_brand"></a> [brand](#input\_brand) | Identifier for BlueLightCard Brands e.g BLC-UK, BLC-DDS, or BLC-AU. Used in naming and tagging to differentiate resources across brands. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment identifier (for example: dev, stage, prod). | `string` | n/a | yes |
| <a name="input_functions"></a> [functions](#input\_functions) | Map of Lambda functions to create | <pre>map(object({<br/>    runtime              = optional(string, "provided.al2")<br/>    architectures        = optional(list(string), ["x86_64"])<br/>    handler              = optional(string, "index.handler")<br/>    package_type         = optional(string, "Zip") # Zip or Image<br/>    timeout              = optional(number, 60)<br/>    memory_size          = optional(number, 512)<br/>    reserved_concurrency = optional(number)<br/>    role_name            = optional(string, null) # If null, a new role will be created with basic Lambda execution permissions<br/>    file_name            = optional(string)       # Required if package_type is Zip<br/>    image_uri            = optional(string)       # Required if package_type is Image<br/>    layers               = optional(list(string), [])<br/>    code = object({<br/>      s3_bucket = string<br/>      s3_key    = string<br/>    })<br/>    environment_variables   = optional(map(string), {})<br/>    event_source_arn        = optional(string)           # ARN of the event source (e.g., SQS queue, SNS topic) to trigger the Lambda function<br/>    event_source_queue_name = optional(string)           # Name of the SQS queue if using SQS as an event source<br/>    starting_position       = optional(string, "LATEST") # Starting position for event source mapping (e.g., LATEST, TRIM_HORIZON)<br/>    batch_size              = optional(number, 1)        # Batch size for event source mapping<br/>    security_group_ids      = optional(list(string), []) # Security groups for Lambda function when using VPC<br/>    sqs_variables           = optional(map(string), {})  # Map of variables to pass to the Lambda function when triggered by SQS events<br/>    tags                    = optional(map(string), {})<br/>  }))</pre> | n/a | yes |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Optional GitHub repository URL to include in tags for traceability. | `string` | `null` | no |
| <a name="input_lambda_security_group"></a> [lambda\_security\_group](#input\_lambda\_security\_group) | Security group ID to associate with Lambda functions for VPC access. Optional if Lambda functions do not require VPC access. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name for the API Gateway. Used in combination with environment and brand for resource naming. | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnet IDs for Lambda functions that require VPC access. Optional if Lambda functions do not require VPC access. | `list(string)` | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | Project or workload identifier used in naming and Terraform Cloud workspace standardization. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
