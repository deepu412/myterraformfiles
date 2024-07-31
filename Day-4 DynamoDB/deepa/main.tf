provider "aws" {
  
}


resource "aws_instance" "dev" {
    ami = "ami-068e0f1a600cd311c"
    instance_type = "t2.micro"
    key_name = "myfirstkp"
    associate_public_ip_address = true
    tags = {
      Name = "haridosa"
    }
}