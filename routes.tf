resource "aws_route" "internet_access_web" {
  route_table_id         = aws_route_table.lbroute.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
