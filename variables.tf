# Common variables

variable "postgresql_server_name" {
  description = "Name of the primary postgresql server. This variable is mandatory."
}

variable "postgresql_resource_group_name" {
  description = "Resource group name of the all resources. This variable is mandatory."
}

# PostgreSQL server variables

variable "has_postgresql_server" {
  description = "If true, the module will create the primary postgresql server. By default the value is true."
  default     = "true"
}

variable "postgresql_location" {
  description = "The locaton to primary postgresql server. The defaul is eastus2."
  default     = "eastus2"
}

variable "postgresql_server_sku_name" {
  description = "The sku name of the postgresql server."
  default     = null
}

variable "postgresql_server_storage_profile_storage_mb" {
  description = "The storage size of the postgresql server. The default value is 5120."
  default     = "5120"
}

variable "postgresql_server_storage_profile_backup_retention_days" {
  description = "The storage profile backup retention in days of the postgresql server. The default value is 7."
  default     = "7"
}

variable "postgresql_server_storage_profile_geo_redundant_backup" {
  description = "The option to enable or disable geo redundant backup cross region of the postgresql server. The default value is Disabled."
  default     = "Disabled"
}

variable "postgresql_server_administrator_login" {
  description = "The administrator login of the postgresql server."
  default     = null
}

variable "postgresql_server_administrator_login_password" {
  description = "The administrator password of the postgresql server."
  default     = null
}

variable "postgresql_server_version" {
  description = "The verson of the postgresql server. The defaul version is 11."
  default     = "11"
}

variable "postgresql_server_ssl_enforcement" {
  description = "Option to use ssl enforcement. By default, this option is Enabled."
  default     = "Enabled"
}

# PostgreSQL database variables

variable "has_postgresql_database" {
  description = "If true, the module will create the postgresql database. By default the value is true."
  default     = "true"
}

variable "postgresql_database_name" {
  description = "The name of the postgresql database."
  default     = null
}

variable "postgresql_database_charset" {
  description = "The database charset. The default value is UTF8."
  default     = "UTF8"
}

variable "postgresql_database_collation" {
  description = "The database collation. The default value is English_United States.1252."
  default     = "English_United States.1252"
}

# PostgreSQL virtual network rule variables

variable "has_primary_postgresql_virtual_network_rule" {
  description = "If true, the module will create the primary postgresql server virtual network rule. By default the value is false."
  default     = "false"
}

variable "postgresql_virtual_network_rule_name" {
  description = "The name of the virtual network rule of the primary postgresql server."
  default     = null
}

variable "postgresql_virtual_network_rule_subnet_id" {
  description = "The subnet id of the virtual network rule of the primary postgresql server."
  default     = null
}

variable "postgresql_virtual_network_rule_ignore_missing_vnet_service_endpoint" {
  description = "The option of the virtual network rule of the primary postgresql server to ignore missing vnet service endpoint. The default value is true."
  default     = "true"
}

# PostgreSQL firewall rule variables

variable "has_primary_postgresql_firewall_rule" {
  description = "If true, the module will create the primary postgresql server firewall rule. By default the value is false."
  default     = "false"
}

variable "postgresql_firewall_rule_name" {
  description = "The name of the firewall rule of the primary postgresql server."
  default     = null
}

variable "postgresql_firewall_rule_start_ip_address" {
  description = "The start ip address of the firewall rule of the primary postgresql server."
  default     = null
}

variable "postgresql_firewall_rule_end_ip_address" {
  description = "The end ip address of the firewall rule of the primary postgresql server."
  default     = null
}

# PostgreSQL geo replication variables

variable "has_postgresql_georeplication" {
  description = "If true, the module will create the postgresql server read replica. By default the value is false."
  default     = "false"
}

variable "postgresql_replica_server_location" {
  description = "The locaton to postgresql read replica server. The defaul is centralus."
  default     = "centralus"
}

variable "postgresql_replica_server_name" {
  description = "The name of the postgresql read replica server."
  default     = null
}

# PostgreSQL replica virtual network rule variables

variable "has_postgresql_replica_virtual_network_rule" {
  description = "If true, the module will create the virtual network rule on the postgresql server read replica. By default the value is false."
  default     = "false"
}

variable "postgresql_replica_virtual_network_rule_name" {
  description = "The name of the virtual network rule of the postgresql read replica server."
  default     = null
}

variable "postgresql_replica_virtual_network_rule_subnet_id" {
  description = "The subnet id of the virtual network rule of the postgresql read replica server."
  default     = null
}

variable "postgresql_replica_virtual_network_rule_ignore_missing_vnet_service_endpoint" {
  description = "The option to ignore missing vnet service endpoint of the postgresql read replica server. The default value is true."
  default     = "true"
}

# PostgreSQL replica firewall rule variables

variable "has_postgresql_replica_firewall_rule" {
  description = "If true, the module will create the firewall rule on the postgresql server read replica. By default the value is false."
  default     = "false"
}

variable "postgresql_replica_firewall_rule_name" {
  description = "The name of the firewall rule of the postgresql read replica server."
  default     = null
}

variable "postgresql_replica_firewall_rule_start_ip_address" {
  description = "The start ip address firewall rule of the postgresql read replica server."
  default     = null
}

variable "postgresql_replica_firewall_rule_end_ip_address" {
  description = "The end ip address firewall rule of the postgresql read replica server."
  default     = null
}