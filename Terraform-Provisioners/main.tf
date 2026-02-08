provider "aws" {
  region = "ap-south-1"
}


data "template_file" "web-userdata" {
        template = "${file("static_linux.sh")}"
}


resource "aws_instance" "example" {
  ami                    = "ami-0ff5003538b60d5ec"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data = "${data.template_file.web-userdata.rendered}"
  key_name = "Pwdless"
  tags = {
    Name = "terraform-example"
  }
}

#security group start here

resource "aws_security_group" "instance" {

  name = var.security_group_name
  vpc_id      = "vpc-0f195039ca5f09296"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
}
#security group end here


variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}

#showing the public IP address using output IP

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}
