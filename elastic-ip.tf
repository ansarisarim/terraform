resource "aws_eip" "terra-eip" {
  for_each = aws_instance.terra-ec2

  instance = each.value.id
  vpc      = true

  # meta-argument
  depends_on = [aws_internet_gateway.terra-igw]
}

