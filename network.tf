resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-sg"
  description = "Security Group para instancias ECS (Permite HTTP y Puertos Dinamicos)"
  vpc_id      = data.aws_vpc.default.id

  # REGLA 1: Tráfico de la Aplicación (Variable)
  ingress {
    description = "Acceso Web App"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # REGLA 2: Puertos dinámicos (Necesario para ECS Agent y actualizaciones)
  ingress {
    description = "Rango puertos dinamicos ECS"
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    description = "SSH para mantenimiento (Opcional)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}