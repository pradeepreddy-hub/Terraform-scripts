provider "aws" {
  region = "ap-south-1"
}
# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Variables
variable "environment" {
  type = string
}

variable "instance_counts" {
  type = map(number)
  default = {
    dev  = 1
    prod = 1
  }
}

# Locals with functions
locals {
  # String functions
  env_lower  = lower(var.environment)
  env_upper  = upper(var.environment)
  account_id = data.aws_caller_identity.current.account_id
  
  # Naming convention using functions
  name_prefix = join("-", [
    "cloudninja",
    local.env_lower,
    data.aws_region.current.name
  ])
  
  # Get instance count
  instance_count = lookup(var.instance_counts, var.environment, 1)
  
  # Get available zones
  az_names = data.aws_availability_zones.available.names
  az_count = length(local.az_names)
  
  # Common tags using merge
  common_tags = merge(
    {
      Environment = local.env_upper
      ManagedBy   = "Terraform"
      AccountID   = local.account_id
      Region      = data.aws_region.current.name
    },
    {
      CreatedBy = data.aws_caller_identity.current.arn
    }
  )
}

# Resources
resource "aws_instance" "app_servers" {
  count         = local.instance_count
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
  
  # Distribute across AZs using element()
  availability_zone = element(local.az_names, count.index)
  
  tags = merge(
    local.common_tags,
    {
      Name = format("%s-app-%02d", local.name_prefix, count.index + 1)
    }
  )
}