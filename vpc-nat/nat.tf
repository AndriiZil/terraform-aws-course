# Nat GW
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-public-1a.id
  depends_on    = [aws_internet_gateway.main-gw]
}

# VPC Setup for NAT
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "main-private-1"
  }
}

# Route associations private
resource "aws_route_table_association" "main-private-1-a" {
  route_table_id = aws_route_table.main-private.id
  subnet_id      = aws_subnet.main-private-1a.id
}

resource "aws_route_table_association" "main-private-2-b" {
  route_table_id = aws_route_table.main-private.id
  subnet_id      = aws_subnet.main-private-2b.id
}

resource "aws_route_table_association" "main-private-3-c" {
  route_table_id = aws_route_table.main-private.id
  subnet_id      = aws_subnet.main-private-3c.id
}