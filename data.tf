# data.tf

# 1. Obtenemos la VPC por defecto de la cuenta
data "aws_vpc" "default" {
  default = true
}

# 2. Obtenemos las subredes (donde van las máquinas)
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# 3. Importamos el Rol de Laboratorio (LabRole) obligatorio
# Esto es CRUCIAL para que las máquinas tengan permiso para hablar con ECS
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

# 4. Buscamos la última versión de la imagen de Amazon Linux 2 optimizada para ECS
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}