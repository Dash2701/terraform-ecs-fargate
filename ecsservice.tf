resource "aws_ecs_service" "app" {
  name            = "app-${terraform.workspace}"
  cluster         = aws_ecs_cluster.app.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.replicas

  network_configuration {
    security_groups = [aws_security_group.ecssg.id]
    subnets         = aws_subnet.ecssubnets.*.id
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.maintg.id
    container_name   = var.container_name
    container_port   = var.container_port
  }

  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"


  depends_on = [aws_alb_listener.listener_http]

  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = merge(
    {
      "Name" : "ECS-service-${terraform.workspace}"
  }, var.default_tags)
}

