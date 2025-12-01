environment = "staging"
region      = "us-east-1"

vpc_cidr = "10.1.0.0/16"

public_subnet_cidrs = [
  "10.1.1.0/24",
  "10.1.2.0/24",
]

private_subnet_cidrs = [
  "10.1.11.0/24",
  "10.1.12.0/24",
]

instance_type    = "t3.micro"
desired_capacity = 2
min_size         = 1
max_size         = 3

db_instance_class        = "db.t3.micro"
db_engine                = "mysql"
db_engine_version        = "8.0"
db_allocated_storage     = 40
db_name                  = "appdb"
db_username              = "admin"
db_password_ssm_parameter = "/staging/app/db/password"

app_bucket_name = "mi-app-bucket-staging-1234"


