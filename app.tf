resource "aws_ecs_task_definition" "app_task" {
  family                   = "${var.project_name}-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = 256
  memory                   = 256
  execution_role_arn       = data.aws_iam_role.lab_role.arn
  task_role_arn            = data.aws_iam_role.lab_role.arn

  container_definitions = jsonencode([
    {
      name      = "game-2048"
      image     = "${aws_ecr_repository.app_repo.repository_url}:v1.0" # Notar el tag v1.0
      cpu       = 256
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port # Requisito rúbrica: HostPort definido [cite: 51]
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app_service" {
  name            = "${var.project_name}-svc"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 1
  launch_type     = "EC2" # Requisito rúbrica: Launch Type EC2 
}