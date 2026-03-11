
variable "brand" {
  description = "Identifier for BlueLightCard Brands e.g BLC-UK, BLC-DDS, or BLC-AU. Used in naming and tagging to differentiate resources across brands."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.brand))
    error_message = "brand must contain only lowercase letters, numbers, and hyphens."
  }
}
# variable "name" {
#   description = "Base name for the API Gateway. Used in combination with environment and brand for resource naming."
#   type        = string

#   validation {
#     condition     = can(regex("^[a-z0-9-]+$", var.name))
#     error_message = "name must contain only lowercase letters, numbers, and hyphens."
#   }
# }
# variable "organization" {
#   description = "Organization identifier used in naming and Terraform Cloud workspace standardization."
#   type        = string

#   validation {
#     condition     = can(regex("^[a-z0-9-]+$", var.organization))
#     error_message = "organization must contain only lowercase letters, numbers, and hyphens."
#   }
# }

variable "project" {
  description = "Project or workload identifier used in naming and Terraform Cloud workspace standardization."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project))
    error_message = "project must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Environment identifier (for example: dev, stage, prod)."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.environment))
    error_message = "environment must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_config" {
  description = "VPC configuration for Lambda functions. If null, Lambda functions will not be associated with a VPC."
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default = null
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch Logs for Lambda functions. Set to 0 for infinite retention."
  type        = number
  default     = 14
}

# variable "workspace_name" {
#   description = "Terraform Cloud workspace name. Defaults to the active terraform.workspace."
#   type        = string
#   default     = null
# }

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "function_description" {
  description = "Description of the Lambda function"
  type        = string
  default     = null
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "nodejs20.x"
}

variable "architectures" {
  description = "Lambda function architectures"
  type        = list(string)
  default     = ["x86_64"]
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "package_type" {
  description = "Lambda function package type (Zip or Image)"
  type        = string
  default     = "Zip"

  validation {
    condition     = contains(["Zip", "Image"], var.package_type)
    error_message = "Invalid package_type specified. It must be either \"Zip\" or \"Image\"."
  }
}

variable "source_code_hash" {
  description = "Hash of the source code to force updates"
  type        = string
  default     = null
}

variable "timeout" {
  description = "Timeout in seconds for the Lambda function"
  type        = number
  default     = 60
}

variable "memory_size" {
  description = "Memory allocation in MB for the Lambda function"
  type        = number
  default     = 512
}

variable "reserved_concurrency" {
  description = "Reserved concurrent executions for the Lambda function"
  type        = number
  default     = null
}

variable "provisioned_concurrency" {
  description = "Provisioned concurrent executions for the Lambda function"
  type        = number
  default     = null
}

variable "role_name" {
  description = "IAM role name for the Lambda function. If null, a new role will be created with basic Lambda execution permissions"
  type        = string
  default     = null

  validation {
    condition     = var.role_name == null || can(regex("^[a-zA-Z0-9-_]+$", var.role_name))
    error_message = "role_name must contain only letters, numbers, hyphens, and underscores."
  }
}

variable "filename" {
  description = "Path to the zip file for Lambda function code (required if package_type is Zip)"
  type        = string
  default     = null
}

variable "image_uri" {
  description = "ECR image URI for Lambda function (required if package_type is Image)"
  type        = string
  default     = null
}

variable "layers" {
  description = "List of Lambda layer ARNs to attach to the function"
  type        = list(string)
  default     = []
}

variable "s3_bucket" {
  description = "S3 bucket containing the Lambda function code"
  type        = string
  default     = null
}

variable "s3_key" {
  description = "S3 key for the Lambda function code"
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

# variable "event_source_arn" {
#   description = "ARN of the event source (e.g., SQS queue, SNS topic) to trigger the Lambda function"
#   type        = string
#   default     = null
# }

# variable "event_source_queue_name" {
#   description = "Name of the SQS queue if using SQS as an event source"
#   type        = string
#   default     = null
# }

# variable "starting_position" {
#   description = "Starting position for event source mapping (e.g., LATEST, TRIM_HORIZON)"
#   type        = string
#   default     = "LATEST"
# }

# variable "batch_size" {
#   description = "Batch size for event source mapping"
#   type        = number
#   default     = 1
# }

variable "security_group_ids" {
  description = "Security group IDs for Lambda function when using VPC"
  type        = list(string)
  default     = []
}

# variable "sqs_variables" {
#   description = "Map of variables to pass to the Lambda function when triggered by SQS events"
#   type        = map(string)
#   default     = {}
# }

variable "tags" {
  description = "Tags to apply to the Lambda function"
  type        = map(string)
  default     = {}
}

variable "lambda_security_group" {
  description = "Security group ID to associate with Lambda functions for VPC access. Optional if Lambda functions do not require VPC access."
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnet IDs for Lambda functions that require VPC access. Optional if Lambda functions do not require VPC access."
  type        = list(string)
  default     = []
}

variable "github_repository" {
  description = "Optional GitHub repository URL to include in tags for traceability."
  type        = string
  default     = null
}
