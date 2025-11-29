output "db_endpoint" {
  value = aws_db_instance.primary.address
}

output "db_security_group_id" {
  value = aws_security_group.db.id
}
