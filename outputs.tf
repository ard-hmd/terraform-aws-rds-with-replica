output "master_db_instance_arn" {
  value = { for idx, instance in aws_db_instance.master_instances : idx => instance.arn }
}

output "master_db_instance_endpoint" {
  value = { for idx, instance in aws_db_instance.master_instances : idx => instance.endpoint }
}

output "master_db_instance_identifier" {
  value = { for idx, instance in aws_db_instance.master_instances : idx => instance.identifier }
}

output "replica_db_instance_arn" {
  value = var.create_replica ? { for idx, instance in aws_db_instance.replica_instances : idx => instance.arn } : {}
}

output "replica_db_instance_endpoint" {
  value = var.create_replica ? { for idx, instance in aws_db_instance.replica_instances : idx => instance.endpoint } : {}
}

output "replica_db_instance_identifier" {
  value = var.create_replica ? { for idx, instance in aws_db_instance.replica_instances : idx => instance.identifier } : {}
}
