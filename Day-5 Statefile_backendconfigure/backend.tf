terraform {
  backend "s3" {
    bucket ="tanujaaa"
    key = "terraform.tfstate"
    region = "ap-south-1"
      

  }
}