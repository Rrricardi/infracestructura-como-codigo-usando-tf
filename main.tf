data "aws_ssm_parameter" "db_password" {
  name = var.db_password_ssm_parameter
}

module "vpc" {
  source = "./modules/vpc"

  name                = "app-${var.environment}"
  cidr_block          = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "storage" {
  source = "./modules/storage"

  bucket_name  = var.app_bucket_name
  environment  = var.environment
}

module "db" {
  source = "./modules/db"

  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  db_instance_class    = var.db_instance_class
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_allocated_storage = var.db_allocated_storage
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = data.aws_ssm_parameter.db_password.value
}

module "compute" {
  source = "./modules/compute"

  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids

  instance_type     = var.instance_type
  desired_capacity  = var.desired_capacity
  max_size          = var.max_size
  min_size          = var.min_size

  db_security_group_id = module.db.db_security_group_id
}