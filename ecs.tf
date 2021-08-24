
resource "aws_ecs_cluster" "app" {
  name = "ecs-${terraform.workspace}"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(
    {
      "Name" : "ECS-cluster-${terraform.workspace}"
  }, var.default_tags)
}