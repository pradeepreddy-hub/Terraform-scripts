/* this is our first file
created using terraform and
god bless you */

provider "aws" {
    region     = "ap-northeast-3"
}


resource "aws_instance" "ourfirst" {
  ami           = "ami-04b0f5834ea4c3e32"
  instance_type = "t3.micro"

tags = { 

Name = "Osaka Instance"
}


}
/*
run
terraform validate
terraform plan
terraform apply
and after checking the instance on aws dashboard
terraform destroy
*/