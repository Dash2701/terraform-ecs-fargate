
resource "aws_subnet" "lbsubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.main_vpc.cidr_block, 4, count.index)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index%2]

  tags = merge(
    {
      "Name" : "lb-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}

resource "aws_subnet" "ecssubnets" {
  count                = var.az_count*2
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.main_vpc.cidr_block, 4, count.index + 2)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index%2]

  tags = merge(
    {
      "Name" : "web-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}

resource "aws_subnet" "dbsubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.main_vpc.cidr_block, 4, count.index + 6)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index%2]

  tags = merge(
    {
      "Name" : "db-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}


resource "aws_db_subnet_group" "databasegroup" {
  name       = "maindb"
  subnet_ids = aws_subnet.dbsubnets.*.id

  tags = merge(
    {
      "Name" : "db-subnetgroup-${terraform.workspace}"
  }, var.default_tags)
}