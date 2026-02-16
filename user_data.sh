#!/bin/bash
# Escribimos el nombre del cluster en el archivo de configuración del agente ECS
echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config