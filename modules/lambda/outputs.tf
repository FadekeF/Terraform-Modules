output "lambda_function_arn" {
  description = "Map of Lambda function names to their ARNs."
  value       = { for name, function in aws_lambda_function.lambda_function : name => function.arn }
}

output "lambda_function_name" {
  description = "Map of Lambda function names to their actual function names."
  value       = { for name, function in aws_lambda_function.lambda_function : name => function.function_name }
}

output "lambda_function_version" {
  description = "Map of Lambda function names to their versions."
  value       = { for name, function in aws_lambda_function.lambda_function : name => function.version }
}

output "lambda_function_qualified_arn" {
  description = "Map of Lambda function names to their qualified ARNs (including version)."
  value       = { for name, function in aws_lambda_function.lambda_function : name => "${function.arn}:${function.version}" }
}

output "lambda_function_role_arn" {
  description = "Map of Lambda function names to their execution role ARNs."
  value       = { for name, function in aws_lambda_function.lambda_function : name => function.role }
}

output "lambda_function_vpc_config" {
  description = "Map of Lambda function names to their VPC configuration (if applicable)."
  value       = { for name, function in aws_lambda_function.lambda_function : name => function.vpc_config }
}
