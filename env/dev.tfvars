environment = "dev"
region      = "us-east-1"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24",
]

instance_type    = "t3.micro"
desired_capacity = 1
min_size         = 1
max_size         = 2

db_instance_class        = "db.t3.micro"
db_engine                = "mysql"
db_engine_version        = "8.0"
db_allocated_storage     = 20
db_name                  = "appdb"
db_username              = "admin"
db_password_ssm_parameter = "/dev/app/db/password"

app_bucket_name = "mi-app-bucket-dev-1234"

