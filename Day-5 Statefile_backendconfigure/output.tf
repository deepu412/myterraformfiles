output "public" {
    value = "aws_instance.localname.public_ip"
    sensitive = true
  
}
output "private" {
    value = "aws_instance.localname.private_ip"
    sensitive = false
  
}