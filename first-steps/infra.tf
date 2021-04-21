data "aws_ip_ranges" "european_ec2" {
  regions  = ["eu-central-1", "eu-west-1"]
  services = ["ec2"]
}

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

resource "aws_instance" "bastion" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  # security_groups             = [aws_security_group.bastion.name]
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.bastion.id
  provisioner "local-exec" {
    command = "echo ${aws_instance.bastion.private_ip} >> private_ips.txt"
  }
}

resource "aws_security_group" "bastion" {
  name   = "bastion-security-group"
  vpc_id = aws_vpc.bastion.id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = data.aws_ip_ranges.european_ec2.cidr_blocks
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    CreateDate = data.aws_ip_ranges.european_ec2.create_date
    SyncToken  = data.aws_ip_ranges.european_ec2.sync_token
  }
}

output "ip" {
  value = aws_instance.bastion.public_ip
}

output "cidr_blocks" {
  value = data.aws_ip_ranges.european_ec2.cidr_blocks
}
