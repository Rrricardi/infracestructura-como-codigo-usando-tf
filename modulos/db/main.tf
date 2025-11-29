resource "aws_db_subnet_group" "this" {
  name       = "db-subnet-${var.environment}"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "db-subnet-${var.environment}"
  }
}

resource "aws_security_group" "db" {
  name        = "sg-db-${var.environment}"
  description = "Acceso a RDS desde la app"
  vpc_id      = var.vpc_id

  # El módulo compute le añadirá reglas de ingreso (via SG). Aquí solo definimos el SG.
  tags = {
    Name        = "sg-db-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_db_instance" "primary" {
  allocated_storage    = var.db_allocated_storage
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]

  skip_final_snapshot = true

  tags = {
    Name        = "rds-primary-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_db_instance" "replica" {
  depends_on          = [aws_db_instance.primary]
  replicate_source_db = aws_db_instance.primary.id
  instance_class      = var.db_instance_class

  skip_final_snapshot = true

  tags = {
    Name        = "rds-replica-${var.environment}"
    Environment = var.environment
  }
}
