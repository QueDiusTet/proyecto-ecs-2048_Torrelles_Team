variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefijo para nombrar los recursos del proyecto"
  type        = string
  default     = "asix2-ecs-2048"
}

variable "ecr_repo_name" {
  description = "Nombre del repositorio ECR para la imagen Docker"
  type        = string
  default     = "asix2-game-repo"
}

variable "app_port" {
  description = "Puerto TCP expuesto para el servicio web (Juego 2048)"
  type        = number
  default     = 80
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para el clúster"
  type        = string
  default     = "t3.micro"
}
