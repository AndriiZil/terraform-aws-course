resource "aws_key_pair" "mykeypair" {
  public_key = file("mykey.pub")
  key_name = "mykeypair"
}
