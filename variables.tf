variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "Región de AWS"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR de la VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDRs de subnets públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs de subnets privadas"
  type        = list(string)
}

variable "instance_type" {
  description = "Tipo de instancia para las EC2"
  type        = string
}

variable "desired_capacity" {
  description = "Capacidad deseada del Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Tamaño máximo del Auto Scaling Group"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Tamaño mínimo del Auto Scaling Group"
  type        = number
  default     = 1
}

variable "db_instance_class" {
  description = "Clase de instancia para RDS"
  type        = string
}

variable "db_engine" {
  description = "Motor de base de datos (mysql, postgres, etc.)"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Versión del motor"
  type        = string
  default     = "8.0"
}

variable "db_allocated_storage" {
  description = "Almacenamiento en GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password_ssm_parameter" {
  description = "Nombre del parámetro en SSM con el password de la DB"
  type        = string
}

variable "app_bucket_name" {
  description = "Nombre del bucket S3 para la app"
  type        = string
}
