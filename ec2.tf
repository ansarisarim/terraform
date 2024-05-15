resource "aws_key_pair" "terra_key_pair" {
  key_name   = "terra-key"
  public_key = "**replace_with_your_public_key**"
}

# Security Group for EC2 Instance
resource "aws_security_group" "terra-ec2-sg" {
  name        = "terra-ec2-sg"
  description = "Security Group for EC2 Instance"
  vpc_id      = aws_vpc.terra-vpc.id

  # ... Define ingress and egress rules here ...
}

# EC2 Instance
resource "aws_instance" "terra-ec2" {
  ami           = "ami-013e83f579886baeb"  # Replace with your desired AMI
  key_name      = aws_key_pair.terra_key_pair.key_name
  instance_type = "t2.micro"               # Consider scaling based on your needs
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.terra-ec2-sg.id]
  count         = 3

  tags = {
    name = "web-${count.index}"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo service httpd start
    sudo systemctl enable httpd
    echo "<h1>Welcome to StackSimplify! AWS infrastructure created using Terraform in ap-south-1 region</h1>" > /var/www/html/index.html
  EOF
}

