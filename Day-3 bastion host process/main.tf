
provider "aws" {
  
}

#vpc code
resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "myvpc"
    }
}
#internet gateway
resource "aws_internet_gateway" "dev" {
    vpc_id = aws_vpc.dev.id
    tags ={
        Name = "my-ig"
    } 
}
#public subnet
resource "aws_subnet" "dev" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.dev.id
    tags = {
      Name="publicsubnet"
    }
  
}
#route table
resource "aws_route_table" "dev" {
    vpc_id = aws_vpc.dev.id
    tags = {
      Name = "my-RT"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev.id
    }
  
}
#subnet association
resource "aws_route_table_association" "dev" {
    subnet_id = aws_subnet.dev.id
    route_table_id = aws_route_table.dev.id
  
}
# security group
resource "aws_security_group" "dev" {
    vpc_id = aws_vpc.dev.id
    name = "mysg22"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 00
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}
#nat gateway
resource "aws_nat_gateway" "dev" {
    connectivity_type = "public"
    allocation_id = aws_eip.dev.id
    subnet_id = aws_subnet.dev.id
    tags = {
      Name = "my-nat"
    }
  
}
resource "aws_eip" "dev" {
    domain = "vpc"
  
}
#private subnet
resource "aws_subnet" "dev2" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "private subnet"
    }
}
#private route
resource "aws_route_table" "dev2" {
    vpc_id = aws_vpc.dev.id
    tags = {
        Name ="my-RT2" 
    }
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.dev.id
    }
  
}
#private route association

resource "aws_route_table_association" "dev2" {
    subnet_id = aws_subnet.dev2.id
    route_table_id = aws_route_table.dev2.id
  
}
#public instance
resource "aws_instance" "dev" {
    ami = "ami-068e0f1a600cd311c"
    instance_type = "t2.micro"
    key_name = "myfirstkp"
    subnet_id = aws_subnet.dev.id
    security_groups = [aws_security_group.dev.id]
    associate_public_ip_address = true
    tags = {
      Name="public-ec2"
    }
  
}
#private instance
resource "aws_instance" "dev2" {
    ami ="ami-068e0f1a600cd311c"
    instance_type = "t2.micro"
    key_name = "myfirstkp"
    subnet_id = aws_subnet.dev2.id
    security_groups = [aws_security_group.dev.id]
     associate_public_ip_address = false
    tags = {
        Name = "private-ec2"
    }

}
