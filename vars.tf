variable "aws_region" {
  default     = "eu-west-3"
  description = "Default AWS region where resources will be created."
}

variable "resource_name_prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "terraform-aws-rds-"
}

variable "database_configurations" {
  description = "List of database configurations."
  type = list(object({
    identifier              = string
    allocated_storage       = number
    engine_version          = string
    instance_class          = string
    db_name                 = string
    db_username             = string
    db_password             = string
    parameter_group_name    = string
    db_subnet_group_name    = string
    skip_final_snapshot     = bool
    publicly_accessible     = bool
    backup_retention_period = number
    vpc_id                  = string
    allowed_cidrs           = list(string)
    sg_name                 = string
    sg_description          = string
    multi_az                = bool
    apply_immediately       = bool  # Added this property for replica configuration
  }))
  default = []
}

variable "create_replica" {
  description = "Boolean to control the creation of RDS replica."
  type        = bool
  default     = false
}
