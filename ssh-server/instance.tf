resource "aws_vpc" "bastion" {
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Bastion VPC"
  }
}

resource "aws_subnet" "bastion" {
  vpc_id     = aws_vpc.bastion.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "app-main"
  }
}

resource "aws_security_group" "bastion" {
  name   = "bastion-security-group"
  vpc_id = aws_vpc.bastion.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "myKey" {
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "example" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.myKey.key_name

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    user = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

}