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
variable "workspace_name" {
  description = "Terraform Cloud workspace name. Defaults to the active terraform.workspace."
  type        = string
  default     = null
  validation {
    condition     = var.workspace_name == null || can(regex("^[a-z0-9-]+$", var.workspace_name))
    error_message = "workspace_name must contain only lowercase letters, numbers, and hyphens."
  }
}
# variable "enforce_workspace_standard" {
#   description = "When true, validates workspace naming against the standard '<organization>-<project>-<environment>'."
#   type        = bool
#   default     = true
# }
variable "brand" {
  description = "Identifier for BlueLightCard Brands e.g BLC-UK, BLC-DDS, or BLC-AU. Used in naming and tagging to differentiate resources across brands."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.brand))
    error_message = "brand must contain only lowercase letters, numbers, and hyphens."
  }
}
variable "service_name" {
  description = "Base name for the API Gateway. Used in combination with environment and brand for resource naming."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.service_name))
    error_message = "service_name must contain only lowercase letters, numbers, and hyphens."
  }
}
# variable "name_separator" {
#   description = "Separator used for standardized names."
#   type        = string
#   default     = "-"
# }
# variable "name_override" {
#   description = "Optional full name override. If unset, a standardized name is built."
#   type        = string
#   default     = null
# }
variable "protocol_type" {
  description = "Protocol type for API Gateway v2 API resource."
  type        = string
  default     = "HTTP"
  validation {
    condition     = contains(["HTTP", "WEBSOCKET"], var.protocol_type)
    error_message = "protocol_type must be either HTTP or WEBSOCKET."
  }
}
variable "api_description" {
  description = "Optional API description."
  type        = string
  default     = null
}
variable "stage_name" {
  description = "Stage name to create. Use '$default' for an auto-deployed default stage."
  type        = string
  default     = "$default"
}
variable "enable_access_logs" {
  description = "Whether to create and attach a CloudWatch access log group."
  type        = bool
  default     = true
}
variable "log_retention_in_days" {
  description = "CloudWatch log retention in days."
  type        = number
  default     = 30
}
variable "route_selection_expression" {
  description = "Route selection expression for WebSocket APIs."
  type        = string
  default     = "$request.body.action"
}
variable "cors_configuration" {
  description = "Optional CORS configuration for HTTP API."
  type = object({
    allow_credentials = optional(bool, null)
    allow_headers     = optional(list(string), null)
    allow_methods     = optional(list(string), null)
    allow_origins     = optional(list(string), null)
    expose_headers    = optional(list(string), null)
    max_age           = optional(number, null)
  })
  default = {}
}
variable "stage_variables" {
  description = "Map of stage variables."
  type        = map(string)
  default     = {}
}
variable "routes" {
  description = "Map of API routes with their Lambda integration configuration"
  type = map(object({
    route_key            = string
    lambda_function_name = string
    integration_uri      = string
    integration_method   = optional(string, "POST")

    authorization_type   = optional(string)
    authorizer_id        = optional(string)
    authorization_scopes = optional(string)
    api_key_required     = optional(bool, false)
    operation_name       = optional(string)
    request_models       = optional(map(string))

    connection_type           = optional(string, "INTERNET")
    content_handling_strategy = optional(string)
    description               = optional(string)
    passthrough_behavior      = optional(string)
  }))
}
variable "create_deployment" {
  description = "Whether to create explicit API Gateway deployments. Recommended when auto_deploy is false."
  type        = bool
  default     = true
}
variable "auto_deploy" {
  description = "Whether to automatically deploy updates to the stage."
  type        = bool
  default     = true
}
# variable "deployment_description" {
#   description = "Optional Description for explicit API Gateway deployments."
#   type        = string
#   default     = null
# }
# variable "deployment_triggers" {
#   description = "Additional Custom Values that should force a new deployment when changed."
#   type        = map(string)
#   default     = {}
# }
variable "integration_type" {
  description = "Optional Description for explicit API Gateway deployments."
  type        = string
  default     = "AWS_PROXY"
}
# variable "base_tags" {
#   description = "Base tags applied to all resources before module standard tags."
#   type        = map(string)
#   default     = {}
# }
# variable "custom_tags" {
#   description = "Additional custom tags merged last to allow controlled overrides."
#   type        = map(string)
#   default     = {}
# }
variable "github_repository" {
  description = "Github repository API Gateway is created in"
  type        = string
}

variable "allow_api_gateway_invoke_lambda" {
  description = "Whether to create permissions allowing API Gateway to invoke Lambda functions. Set to false if permissions are managed outside of this module."
  type        = bool
  default     = false
}
