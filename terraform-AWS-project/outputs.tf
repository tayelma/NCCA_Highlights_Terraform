output "vpc_id" {
    value = aws_vpc.GameHighlights-VPC.id
  }


output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
  }


output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
  }

output "IGW_id" {
  value = aws_internet_gateway.GameHighlights-IGW.id
}