resource "aws_s3_bucket" "terra-bucket" {
  bucket = "terra-bucket"
  acl = "public-read"

  tags = {
    Name = "terrabucket"
  }
}
