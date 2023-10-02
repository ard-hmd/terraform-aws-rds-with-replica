# Define the security group for RDS databases
resource "aws_security_group" "rds_sg" {
  for_each = { for idx, config in var.database_configurations : idx => config }

  name        = each.value.sg_name
  description = each.value.sg_description
  vpc_id      = each.value.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = each.value.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = each.value.sg_name
    Prefix = var.resource_name_prefix
  }
}

resource "aws_db_instance" "master_instances" {
  for_each = { for idx, config in var.database_configurations : idx => config }

  engine                  = "mysql"
  identifier              = each.value.identifier
  allocated_storage       = each.value.allocated_storage
  engine_version          = each.value.engine_version
  instance_class          = each.value.instance_class
  db_name                 = each.value.db_name
  username                = each.value.db_username
  password                = each.value.db_password
  parameter_group_name    = each.value.parameter_group_name
  db_subnet_group_name    = each.value.db_subnet_group_name
  skip_final_snapshot     = each.value.skip_final_snapshot
  publicly_accessible     = each.value.publicly_accessible
  backup_retention_period = each.value.backup_retention_period
  multi_az                = each.value.multi_az
  vpc_security_group_ids  = [aws_security_group.rds_sg[each.key].id]

  tags = {
    Name   = each.value.identifier
    Prefix = var.resource_name_prefix
  }
}

resource "aws_db_instance" "replica_instances" {
  count = var.create_replica ? length(var.database_configurations) : 0

  engine                  = "mysql"
  identifier              = "${var.database_configurations[count.index].identifier}-replica"
  instance_class          = var.replica_configurations[count.index].instance_class
  replicate_source_db     = aws_db_instance.master_instances[count.index].identifier
  backup_retention_period = var.replica_configurations[count.index].backup_retention_period
  multi_az                = var.replica_configurations[count.index].multi_az
  apply_immediately       = var.replica_configurations[count.index].apply_immediately
  vpc_security_group_ids  = [aws_security_group.rds_sg[count.index].id]

  tags = {
    Name = "${var.resource_name_prefix}${var.database_configurations[count.index].identifier}-replica"
  }
}
