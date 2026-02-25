# Proyecto ECS - Despliegue de Juego 2048

Este proyecto despliega una infraestructura de alta disponibilidad en AWS utilizando **Terraform**.
Consiste en un clúster ECS con instancias EC2 que ejecutan el juego 2048 en contenedores Docker, gestionado mediante un Auto Scaling Group.

## 🚀 Arquitectura
* **IaC:** Terraform (Modularizado)
* **Computación:** AWS ECS (EC2 Launch Type) + Auto Scaling Group
* **Red:** VPC Default con Security Groups personalizados (Puertos dinámicos + HTTP)
* **Contenedor:** Docker (Nginx + 2048 Game)
* **Almacenamiento:** AWS ECR (Elastic Container Registry)
*Nota:* Validado en entorno AWS Academy v2.0

## 🛠️ Despliegue (Quick Start)

1. **Prerrequisitos:**
   * Tener AWS CLI configurado (`aws configure` o credenciales de lab).
   * Tener Terraform instalado.

2. **Inicializar Terraform:**
   ```bash
   terraform init
