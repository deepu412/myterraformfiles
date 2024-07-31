module "test" {
    source = "../day-2 basic_code"
    ami_id  = "ami-068e0f1a600cd311c"
    instance_type = "t2.micro"
    key_name = "myfirstkp"
    
  
}