module "consul" {
  source = "github.com/..."
  key_name = aws_key_pair.myKey.key_name
  key_path = var.PATH_TO_PRIVATE_KEY
}
