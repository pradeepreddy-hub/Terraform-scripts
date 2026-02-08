/* this is our first file
created using terraform and
god bless you */

provider "aws" {
    region     = "ap-south-1"
}

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1a"
  size              = 40
  
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_instance" "ourfirst" {
  ami           = "ami-0ff5003538b60d5ec"
  instance_type = "t3.micro"

tags = { 

Name = "mumbai instance"
}

}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.example.id}"
  instance_id = aws_instance.ourfirst.id
  depends_on = [
    aws_instance.ourfirst,
    aws_ebs_volume.example
    
  ]
}

output "instancestatus" {
    value = aws_volume_attachment.ebs_att
   
}


/*
run
terraform validate
terraform plan
terraform apply
and after checking the instance on aws dashboard
terraform destroy
*/

