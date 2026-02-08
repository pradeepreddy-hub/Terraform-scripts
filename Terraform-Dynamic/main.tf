/*resource "aws_security_group" "demo_sg" {
  name        = "sample-sg"

  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8201
    to_port     = 8201
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9500
    to_port     = 9500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



provider "aws" {
  region = "ap-south-1"
}

variable "sg_ports" {
  type = list(number)
  default = [8200,8201,8300,9200,9500]
}

 resource "aws_security_group" "demo_sg" {
  name        = "sample-sg"

  dynamic "ingress" {
    for_each = var.sg_ports
    content {
       from_port   = ingress.value
       to_port     = ingress.value
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }
  }
}*/

/*provider "aws" {
  region = "ap-south-1"
}
variable "user_names" {
  type    = set(string)
  default = ["alice", "bob", "john", "james"]
}

resource "aws_iam_user" "this" {
  for_each = var.user_names

  name = each.value
}*/

provider "aws" {
  region = "ap-south-1"
}

variable "user_names" {
  type    = list(string)
  default = ["alice", "bob", "john", "james"]
}

resource "aws_iam_user" "this" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}