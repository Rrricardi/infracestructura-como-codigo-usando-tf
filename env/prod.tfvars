environment = "prod"
region      = "us-east-1"

vpc_cidr = "10.2.0.0/16"

public_subnet_cidrs = [
  "10.2.1.0/24",
  "10.2.2.0/24",
]

private_subnet_cidrs = [
  "10.2.11.0/24",
  "10.2.12.0/24",
]

instance_type    = "t3.micro"
desired_capacity = 3
min_size         = 2
max_size         = 6

db_instance_class        = "db.t3.micro"
db_engine                = "mysql"
db_engine_version        = "8.0"
db_allocated_storage     = 100
db_name                  = "appdb"
db_username              = "admin"
db_password_ssm_parameter = "/prod/app/db/password"

app_bucket_name = "mi-app-bucket-prod-1234"

