resource "aws_instance" "web" {
  ami           = "ami-087c3138d6ccce963"
  instance_type = "t2.micro"
}
