# Data source para obtener el password desde SSM Parameter Store
data "aws_ssm_parameter" "db_password" {
  name = var.db_password_ssm_parameter
}

# Módulo de VPC
module "vpc" {
  source = "./modulos/vpc"

  # ✅ CORREGIDO: Usar environment en lugar de name
  environment          = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  
  # ✅ AGREGAR: Pasar common_tags si tu módulo VPC los usa
  common_tags         = var.common_tags
}

# Módulo de Storage (S3)
module "storage" {
  source = "./modulos/storage"

  bucket_name  = var.app_bucket_name
  environment  = var.environment
  common_tags  = var.common_tags
}

# Módulo de Database (RDS)
module "db" {
  source = "./modulos/db"

  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids  # ← Verificar que este output existe
  db_instance_class    = var.db_instance_class
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_allocated_storage = var.db_allocated_storage
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = data.aws_ssm_parameter.db_password.value
  common_tags          = var.common_tags
}

# Módulo de Compute (EC2 + Auto Scaling)
module "compute" {
  source = "./modulos/compute"

  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids    # ← Verificar que este output existe
  private_subnet_ids  = module.vpc.private_subnet_ids   # ← Verificar que este output existe

  instance_type     = var.instance_type
  desired_capacity  = var.desired_capacity
  max_size          = var.max_size
  min_size          = var.min_size

  db_security_group_id = module.db.db_security_group_id  # ← Verificar que este output existe
  common_tags          = var.common_tags
}
