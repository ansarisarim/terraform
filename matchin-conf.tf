resource "aws_instance" "terra-EC2" {
  ami             = "ami-0f58b397bc5c1f2e8"
  instance_type   = "t2.micro"
  security_groups = ["default"]
  key_name        = "abc.pem"
}

