
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
variable "enable_key_rotation" {
  description = "Whether to enable automatic key rotation for the S3 bucket."
  type        = bool
  default     = true
}
variable "existing_kms_key_id" {
  description = "Optional existing KMS key ID or ARN to use for S3 bucket encryption. If not provided, a new KMS key will be created."
  type        = string
  default     = null
}
variable "enable_lifecycle_rule" {
  description = "Whether to enable the S3 bucket lifecycle rule for automatic object expiration."
  type        = bool
  default     = false
}
variable "bucket_expiration_days" {
  description = "Number of days after which objects in the S3 bucket will expire. Only applicable if enable_lifecycle_rule is true."
  type        = number
  default     = 60
}
variable "block_public_acls" {
  description = "Whether to block public ACLs on the S3 bucket."
  type        = bool
  default     = true
}
variable "block_public_policy" {
  description = "Whether to block public policy on the S3 bucket."
  type        = bool
  default     = true
}
variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs on the S3 bucket."
  type        = bool
  default     = true
}
variable "restrict_public_buckets" {
  description = "Whether to restrict public buckets on the S3 bucket."
  type        = bool
  default     = true
}
variable "versioning_enabled" {
  description = "Whether to enable versioning on the S3 bucket."
  type        = bool
  default     = false
}
variable "github_repository" {
  description = "Optional GitHub repository URL to include in tags for traceability."
  type        = string
  default     = null
}
