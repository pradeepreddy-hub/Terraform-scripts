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
  region="ap-south-1"
}

locals {

  env="${terraform.workspace}"

  counts = {
    "default"=1
    "prod"=3
    "dev"=2
  }

  instances = {
    "default"="t3.micro"
    "prod"="t2.small"
    "dev"="t3.small"
  }

  tags = {
    "default"="webserver-def"
    "prod"="webserver-prod"
    "dev"="webserver-dev"
  }


  instance_type="${lookup(local.instances,local.env)}"
  count="${lookup(local.counts,local.env)}"
  mytag="${lookup(local.tags,local.env)}"

}


resource "aws_instance" "my_work" {
 ami="ami-0ff5003538b60d5ec"
 instance_type="${local.instance_type}"
 count="${local.count}"
 tags = {
    Name="${local.mytag}"
 }

}