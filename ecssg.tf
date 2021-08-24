resource "aws_security_group" "ecssg" {
  name        = "ecssg-${terraform.workspace}"
  description = "controls access to the LB"
  vpc_id      = aws_vpc.main_vpc.id
  tags = merge(
    {
      "Name" : "ecssg-${terraform.workspace}"
    }, var.default_tags
  )
}


resource "aws_security_group_rule" "lb_to_ecs" {
  security_group_id        = aws_security_group.ecssg.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lbsg.id
}



resource "aws_security_group_rule" "ecs_egress" {
  security_group_id = aws_security_group.ecssg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

