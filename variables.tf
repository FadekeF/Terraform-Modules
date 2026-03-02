
variable "brand" {
  description = "Identifier for BlueLightCard Brands e.g BLC-UK, BLC-DDS, or BLC-AU. Used in naming and tagging to differentiate resources across brands."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.brand))
    error_message = "brand must contain only lowercase letters, numbers, and hyphens."
  }
}
variable "name" {
  description = "Base name for the API Gateway. Used in combination with environment and brand for resource naming."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "name must contain only lowercase letters, numbers, and hyphens."
  }
}
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

# variable "workspace_name" {
#   description = "Terraform Cloud workspace name. Defaults to the active terraform.workspace."
#   type        = string
#   default     = null
# }

variable "functions" {
  description = "Map of Lambda functions to create"
  type = map(object({
    runtime              = optional(string, "provided.al2")
    architectures        = optional(list(string), ["x86_64"])
    handler              = optional(string, "index.handler")
    package_type         = optional(string, "Zip") # Zip or Image
    timeout              = optional(number, 60)
    memory_size          = optional(number, 512)
    reserved_concurrency = optional(number)
    role_name            = optional(string, null) # If null, a new role will be created with basic Lambda execution permissions
    filename             = optional(string)       # Required if package_type is Zip
    image_uri            = optional(string)       # Required if package_type is Image
    layers               = optional(list(string), [])
    s3_bucket            = optional(string)
    s3_key               = optional(string)

    environment_variables   = optional(map(string), {})
    event_source_arn        = optional(string)           # ARN of the event source (e.g., SQS queue, SNS topic) to trigger the Lambda function
    event_source_queue_name = optional(string)           # Name of the SQS queue if using SQS as an event source
    starting_position       = optional(string, "LATEST") # Starting position for event source mapping (e.g., LATEST, TRIM_HORIZON)
    batch_size              = optional(number, 1)        # Batch size for event source mapping
    security_group_ids      = optional(list(string), []) # Security groups for Lambda function when using VPC
    sqs_variables           = optional(map(string), {})  # Map of variables to pass to the Lambda function when triggered by SQS events
    tags                    = optional(map(string), {})
  }))

  validation {
    condition     = alltrue([for k, v in var.functions : contains(["Zip", "Image"], v.package_type)])
    error_message = "Invalid package_type specified. It must be either \"Zip\" or \"Image\"."
  }

  validation {
    condition     = alltrue([for k, v in var.functions : (v.package_type == "Zip" && v.filename != null) || (v.package_type == "Image" && v.image_uri != null)])
    error_message = "For package_type \"Zip\", filename must be provided. For package_type \"Image\", image_uri must be provided."
  }

  validation {
    condition     = alltrue([for k, v in var.functions : v.role_name == null || can(regex("^[a-zA-Z0-9-_]+$", v.role_name))])
    error_message = "role_name must contain only letters, numbers, hyphens, and underscores."
  }

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
