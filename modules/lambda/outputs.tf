output "function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.lambda_function.arn
}

output "function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.lambda_function.function_name
}

output "function_invoke_arn" {
  description = "Invoke ARN of the Lambda function."
  value       = aws_lambda_function.lambda_function.invoke_arn
}
output "function_version" {
  description = "Version of the Lambda function."
  value       = aws_lambda_function.lambda_function.version
}

output "function_qualified_arn" {
  description = "Qualified ARN of the Lambda function (including version)."
  value       = "${aws_lambda_function.lambda_function.arn}:${aws_lambda_function.lambda_function.version}"
}

output "function_role_arn" {
  description = "ARN of the Lambda function execution role."
  value       = aws_lambda_function.lambda_function.role
}

output "function_vpc_config" {
  description = "VPC configuration of the Lambda function (if applicable)."
  value       = aws_lambda_function.lambda_function.vpc_config
}
