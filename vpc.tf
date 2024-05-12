resource "aws_vpc" "terra-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "terra-vpc"
  }
}







