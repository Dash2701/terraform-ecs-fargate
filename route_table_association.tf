

resource "aws_route_table_association" "private_route_db_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.dbsubnets.*.id, count.index)
  route_table_id = aws_route_table.dbroute.id
}


resource "aws_route_table_association" "private_route_ecs_table_association" {
  count          = var.az_count * 2
  subnet_id      = element(aws_subnet.ecssubnets.*.id, count.index)
  route_table_id = aws_route_table.ecsroute.id
}



resource "aws_route_table_association" "public_web_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.lbsubnets.*.id, count.index)
  route_table_id = aws_route_table.lbroute.id
}

