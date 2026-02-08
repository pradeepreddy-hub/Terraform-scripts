provider "aws" {
    region     = "ap-south-1"
}

import {
  to = aws_instance.example
  id = "i-06c3d3d309a798902"
  
  
}

resource "aws_instance" "example" {
  ### Configuration omitted for brevity ###
  instance_type = "t3.micro"
  ami = "ami-02b8269d5e85954ef"
}

