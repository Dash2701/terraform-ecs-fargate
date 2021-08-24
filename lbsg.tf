resource "aws_security_group" "lbsg" {
  name        = "lbsg-${terraform.workspace}"
  description = "controls access to the LB"
  vpc_id      = aws_vpc.main_vpc.id
  tags = merge(
    {
      "Name" : "lbsg-${terraform.workspace}"
    }, var.default_tags
  )
}


resource "aws_security_group_rule" "web_to_lb" {
  security_group_id = aws_security_group.lbsg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

}


resource "aws_security_group_rule" "lb_egress" {
  security_group_id = aws_security_group.lbsg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
