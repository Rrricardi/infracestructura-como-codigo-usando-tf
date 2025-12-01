terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend remoto en S3 (remote state + locking en DynamoDB)
  backend "s3" {
    bucket         = "thomas-iac-state"    # <- cámbialo
    key            = "multi-env/terraform.tfstate"  # puedes usar workspaces
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}
