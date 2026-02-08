variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Environment tag (dev, qa, prod)"
  type        = string
  default     = "dev"
}
