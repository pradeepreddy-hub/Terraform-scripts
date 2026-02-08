terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

#################
# EC2 Instance
#################
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

#################
# Elastic IP
#################
resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name = "${var.instance_name}-eip"
  }
}

#################
# EIP Association
#################
resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this.id
}

#################
# Outputs
#################
output "ec2_instance_id" {
  value = aws_instance.this.id
}

output "elastic_ip" {
  value = aws_eip.this.public_ip
}
