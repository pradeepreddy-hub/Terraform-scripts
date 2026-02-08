data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  depends_on = [
    aws_vpc.main,
    aws_security_group.ec2_sg
  ]

  tags = {
    Name = "terraform-ec2"
  }
}


