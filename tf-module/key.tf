resource "aws_key_pair" "myKey" {
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}