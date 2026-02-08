terraform {
  backend "s3" {
    bucket       = "my-unique-s3-pradeep"
    key          = "tf_state/workspace/terraform.tfstate"
    use_lockfile = true
    region       = "ap-south-1"
    encrypt = true
  }
}

provider "aws" {
    region     = "ap-south-1"
}

module "ec2" {
    source = "../ec2-module"
    ami_id = "ami-0ff5003538b60d5ec"
    instance_type = "t3.micro"
    vpc_id = "vpc-0f195039ca5f09296"
    port = "22"
    cidr_blocks = "0.0.0.0/0"

}