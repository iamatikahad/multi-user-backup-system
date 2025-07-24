provider "aws" { region = "us-east-1" }
resource "aws_instance" "vm" { ami = "ami-xxxxxx"; instance_type = "t2.micro" }