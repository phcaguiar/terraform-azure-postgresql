resource "azurerm_postgresql_server" "postgresql_server" {
  count               = var.has_postgresql_server ? 1 : 0
  name                = var.postgresql_server_name
  location            = var.postgresql_location
  resource_group_name = var.postgresql_resource_group_name

  sku_name = var.postgresql_server_sku_name

  storage_profile {
    storage_mb            = var.postgresql_server_storage_profile_storage_mb
    backup_retention_days = var.postgresql_server_storage_profile_backup_retention_days
    geo_redundant_backup  = var.postgresql_server_storage_profile_geo_redundant_backup
  }

  administrator_login          = var.postgresql_server_administrator_login
  administrator_login_password = var.postgresql_server_administrator_login_password
  version                      = var.postgresql_server_version
  ssl_enforcement              = var.postgresql_server_ssl_enforcement
}

resource "azurerm_postgresql_database" "postgresql_database" {
  count                    = var.has_postgresql_database ? 1 : 0
  name                     = var.postgresql_database_name
  resource_group_name      = var.postgresql_resource_group_name
  server_name              = var.postgresql_server_name
  charset                  = var.postgresql_database_charset
  collation                = var.postgresql_database_collation

  depends_on               = [azurerm_postgresql_server.postgresql_server]
  
}

resource "azurerm_postgresql_virtual_network_rule" "postgresql_virtual_network_rule" {
  count                                = var.has_primary_postgresql_virtual_network_rule ? 1 : 0
  name                                 = var.postgresql_virtual_network_rule_name
  resource_group_name                  = var.postgresql_resource_group_name
  server_name                          = var.postgresql_server_name
  subnet_id                            = var.postgresql_virtual_network_rule_subnet_id
  ignore_missing_vnet_service_endpoint = var.postgresql_virtual_network_rule_ignore_missing_vnet_service_endpoint
  depends_on                           = [azurerm_postgresql_server.postgresql_server]
}

resource "azurerm_postgresql_firewall_rule" "postgresql_firewall_rule" {
  count               = var.has_primary_postgresql_firewall_rule ? 1 : 0
  name                = var.postgresql_firewall_rule_name
  resource_group_name = var.postgresql_resource_group_name
  server_name         = var.postgresql_server_name
  start_ip_address    = var.postgresql_firewall_rule_start_ip_address
  end_ip_address      = var.postgresql_firewall_rule_end_ip_address
  depends_on          = [azurerm_postgresql_server.postgresql_server]
}

resource "null_resource" "postgresql_enable_replication" {
  count      = var.has_postgresql_georeplication ? 1 : 0

  provisioner "local-exec" {
    command  = "az postgres server configuration set -g ${var.postgresql_resource_group_name} -s ${var.postgresql_server_name} -n azure.replication_support --value REPLICA"
  }

  depends_on = [azurerm_postgresql_database.postgresql_database]

}

resource "null_resource" "postgresql_restart_primary_server" {
  count      = var.has_postgresql_georeplication ? 1 : 0

  provisioner "local-exec" {
    command  = "az postgres server restart -n ${var.postgresql_server_name} -g ${var.postgresql_resource_group_name}"
  }

  depends_on = [null_resource.postgresql_enable_replication]

}

resource "null_resource" "postgresql_create_read_replica" {
  count      = var.has_postgresql_georeplication ? 1 : 0

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    # command  = "az postgres server replica create -n '/subscriptions/${var.postgresql_replica_server_subscription_id}/resourceGroups/${var.postgresql_replica_server_resource_group_name}/providers/Microsoft.DBforPostgreSQL/servers/${var.postgresql_replica_server_name}' -s ${azurerm_postgresql_server.postgresql_server.name} -g ${var.postgresql_replica_server_resource_group_name} -l ${var.postgresql_replica_server_location}"
    command  = "az postgres server replica create -n ${var.postgresql_replica_server_name} -s ${var.postgresql_server_name} -g ${var.postgresql_resource_group_name} -l ${var.postgresql_replica_server_location}"
  }

  depends_on = [null_resource.postgresql_restart_primary_server]

}

resource "azurerm_postgresql_virtual_network_rule" "postgresql_replica_virtual_network_rule" {
  count                                = var.has_postgresql_georeplication && var.has_postgresql_replica_virtual_network_rule ? 1 : 0
  name                                 = var.postgresql_replica_virtual_network_rule_name
  resource_group_name                  = var.postgresql_resource_group_name
  server_name                          = var.postgresql_replica_server_name
  subnet_id                            = var.postgresql_replica_virtual_network_rule_subnet_id
  ignore_missing_vnet_service_endpoint = var.postgresql_replica_virtual_network_rule_ignore_missing_vnet_service_endpoint
  depends_on                           = [null_resource.postgresql_create_read_replica]
}

resource "azurerm_postgresql_firewall_rule" "postgresql_replica_firewall_rule" {
  count               = var.has_postgresql_georeplication && var.has_postgresql_replica_firewall_rule ? 1 : 0

  name                = var.postgresql_firewall_rule_name
  resource_group_name = var.postgresql_resource_group_name
  server_name         = var.postgresql_replica_server_name
  start_ip_address    = var.postgresql_replica_firewall_rule_start_ip_address
  end_ip_address      = var.postgresql_replica_firewall_rule_end_ip_address
  depends_on          = [null_resource.postgresql_create_read_replica]
}