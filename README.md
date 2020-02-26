# Terraform Azure PostgreSQL Module

This module creates an Azure PostgreSQL following the best practices defined by the SRE/Cloud team at Stone CO.

## Requirements

- Terraform version 0.12+
- Azurerm Provider version 2.0+ (tested on version 2.0.0)
- Terraform Null Provider version 2.1.2

## How to use

The following parameters are mandatory for all resources of this module:

Note: See all variables options in `variables.tf` file.

- ``redis_cache_resource_group_name``: All resources in this module will be created in this resource group. Ex: Infrastructure-Common-EC2-DEV
- ``redis_cache_name``: Name of the redis cache.
- ``redis_cache_location``: The location of the redis cache
- ``redis_cache_capacity``: Redis cache capacity
- ``redis_cache_family``: Redis cache family
- ``redis_cache_sku_name``: Redis cache sku name

The following parameters are mandatory to enable geo replication:

- ``has_redis_cache_georeplication``: To use this configuration, set value to `true`. To enable geo replication, it is necessary to create two redis in different regions.
- ``redis_cache_georeplication_name``: The name of the geo replication redis cache

The example below will create a redis cache:

```hcl
module "postgresql" {

  "git@github.com:stone-payments/terraform-azure-postgresql.git?ref=v1.0.0" # see tags for available versions./modules/redis"

  redis_cache_name                = "..."
  redis_cache_location            = "..."
  redis_cache_resource_group_name = "..."
  redis_cache_capacity            = "..."
  redis_cache_family              = "..."
  redis_cache_sku_name            = "..."

}
```

## Contributing

Contributions of all forms are welcome. Just open a new issue or pull request.