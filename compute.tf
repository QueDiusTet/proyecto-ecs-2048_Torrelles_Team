# compute.tf

# 1. El Clúster ECS (El cerebro)
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

# 2. El Molde de las Máquinas (Launch Template)
resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.amazon_linux_2.id # Usamos la AMI optimizada que buscamos en data.tf
  instance_type = "t3.micro"                     # Tipo de instancia barata

  # Perfil de permisos OBLIGATORIO en Learner Lab
  iam_instance_profile {
    name = "LabInstanceProfile"
  }

  # Le asignamos el Security Group que creamos antes
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]

  # Le inyectamos el script user_data.sh rellenando la variable
  user_data = base64encode(templatefile("user_data.sh", {
    cluster_name = aws_ecs_cluster.main.name
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-node"
    }
  }
}

# 3. El Gestor de Flota (Auto Scaling Group)
resource "aws_autoscaling_group" "ecs_asg" {
  name                = "${var.project_name}-asg"
  vpc_zone_identifier = data.aws_subnets.default.ids # Usamos las subredes de tu cuenta
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1 # Empezamos con 1 máquina

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  # Etiqueta especial para que ECS sepa que estas máquinas son suyas
  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}