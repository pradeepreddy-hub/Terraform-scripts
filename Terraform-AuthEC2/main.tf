/* this is our first file
created using terraform and
god bless you */

provider "aws" {
  region     = "ap-south-1"
}
provider "aws" {
  region     = "ap-northeast-1"
  alias = "Tokyo"
}
resource "aws_instance" "ourfirst" {
  ami           = "ami-0ced6a024bb18ff2e"
  instance_type = "t3.micro"
  tags = {
    Name = "Mumbai Instance"
  }
}
resource "aws_instance" "oursecond" {
  provider = aws.Tokyo
  ami           = "ami-06cce67a5893f85f9"
  instance_type = "t3.micro"
  tags = {
    Name = "Tokyo Instance"
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
