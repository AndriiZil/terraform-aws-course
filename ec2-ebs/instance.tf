resource "aws_instance" "example" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-public-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-central-1a"
  size = 20
  type = "gp2"

  tags = {
    Name = "Extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  instance_id = aws_instance.example.id
  volume_id = aws_ebs_volume.ebs-volume-1.id
}
