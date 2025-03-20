resource "aws_vpc" "GameHighlights-VPC" {
     cidr_block = "10.0.0.0/16"
     enable_dns_hostnames = true
     enable_dns_support = true   

    tags = {
        Name = "GameHighlights-VPC"
    }
  
}

resource "aws_internet_gateway" "GameHighlights-IGW" {
    vpc_id = aws_vpc.GameHighlights-VPC.id

    tags ={
        Name = "GameHighlights-IGW"
    }
  }

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.GameHighlights-VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.GameHighlights-VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_route_table" "GameHighlights_RT" {
    vpc_id =  aws_vpc.GameHighlights-VPC.id

    tags = {
          Name = "GameHighlights_RT"
    } 
}

resource "aws_route" "r" {
  route_table_id            = aws_route_table.GameHighlights_RT.id
  destination_cidr_block    =  "0.0.0.0/0"
  gateway_id = aws_internet_gateway.GameHighlights-IGW.id
}

resource "aws_route_table" "GameHighlights_RT2" {
    vpc_id =  aws_vpc.GameHighlights-VPC.id
    tags = {
          Name = "GameHighlights_RT2"
    } 
}

resource "aws_route_table_association" "r1" {
  route_table_id = aws_route_table.GameHighlights_RT.id
  subnet_id = aws_subnet.public_subnet.id
}

resource "aws_route_table_association" "r2" {
  route_table_id = aws_route_table.GameHighlights_RT2.id
  subnet_id = aws_subnet.private_subnet.id
}

resource "aws_security_group" "GameHighlights-SG" {
  name        = "GameHighlights-SG"
  description = "Allow HTTPS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.GameHighlights-VPC.id

  tags = {
    Name = "GameHighlights-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  security_group_id = aws_security_group.GameHighlights-SG.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.GameHighlights-SG.id
  cidr_ipv4   = "0.0.0.0/0"
  #from_port   = 0
  ip_protocol = "-1" # Allow all outbound traffic
  #to_port     = 0
}