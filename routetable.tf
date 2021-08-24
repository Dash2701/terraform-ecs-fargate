
resource "aws_route_table" "lbroute" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge({
    Name = "webroute-${terraform.workspace}"
  }, var.default_tags)
}



resource "aws_route_table" "ecsroute" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge({
    Name = "dbroute-${terraform.workspace}"
  }, var.default_tags)
}


resource "aws_route_table" "dbroute" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge({
    Name = "dbroute-${terraform.workspace}"
  }, var.default_tags)
}


