provider "aws" {
  region = "ap-south-1"
}

####################
# VARIABLES
####################

variable "server_names" {
  type    = list(string)
  default = ["dev", "qa", "prod"]
}

variable "instance_types" {
  type = map(string)
  default = {
    dev  = "t3.micro"
    qa   = "t3.micro"
    prod = "t3.small"
  }
}

variable "create_backup" {
  type    = bool
  default = true
}

####################
# LOCALS
####################

locals {
  default = {
    Team         = "security-team"
    CreationDate = "date-${formatdate("DDMMYYYY", timestamp())}"
  }
}

####################
# SECURITY GROUPS
####################

resource "aws_security_group" "sg_01" {
  name = "app_firewall"
  tags = local.default
}

resource "aws_security_group" "sg_02" {
  name = "db_firewall"
  tags = local.default
}

####################
# EC2 INSTANCES
####################

resource "aws_instance" "ourfirst" {
  count         = length(var.server_names)
  ami           = "ami-0ff5003538b60d5ec"
  instance_type = var.instance_types[var.server_names[count.index]]

  vpc_security_group_ids = [
    aws_security_group.sg_01.id,
    aws_security_group.sg_02.id
  ]

  tags = {
    Name = var.server_names[count.index]
  }
}

####################
# EBS VOLUME
####################

resource "aws_ebs_volume" "main" {
  availability_zone = aws_instance.ourfirst[0].availability_zone
  size              = 20
  tags              = local.default
}

####################
# VOLUME ATTACHMENT
####################

resource "aws_volume_attachment" "main_attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.main.id
  instance_id = aws_instance.ourfirst[0].id
}

####################
# SNAPSHOT (OPTIONAL)
####################

resource "aws_ebs_snapshot" "backup" {
  count     = var.create_backup ? 1 : 0
  volume_id = aws_ebs_volume.main.id

  tags = {
    Name = "main-backup"
  }
}
