output "db_instance_arn" {
  description = "The ARN of the RDS instances"
  value       = { for idx, instance in aws_db_instance.my_db_instances : idx => instance.arn }
}

output "db_instance_endpoint" {
  description = "The connection endpoints of the RDS instances"
  value       = { for idx, instance in aws_db_instance.my_db_instances : idx => instance.endpoint }
}

output "db_instance_identifier" {
  description = "The identifiers of the RDS instances"
  value       = { for idx, instance in aws_db_instance.my_db_instances : idx => instance.identifier }
}

output "rds_security_group_ids" {
  description = "The IDs of the Security Groups associated with the RDS instances."
  value       = { for idx, sg in aws_security_group.rds_sg : idx => sg.id }
}

output "replica_db_instance_arn" {
  description = "The Amazon Resource Name (ARN) of the RDS replica instance."
  value       = var.create_replica ? { for idx, instance in aws_db_instance.replica-myinstance : idx => instance.arn } : {}
}

output "replica_db_instance_endpoint" {
  description = "The connection endpoint for the RDS replica instance."
  value       = var.create_replica ? { for idx, instance in aws_db_instance.replica-myinstance : idx => instance.endpoint } : {}
}

output "replica_db_instance_identifier" {
  description = "The connection identifier for the RDS replica instance."
  value       = var.create_replica ? { for idx, instance in aws_db_instance.replica-myinstance : idx => instance.identifier } : {}
}
