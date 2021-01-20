# Observability / Grafana

Terraform module which configure grafana resources on Google Cloud.

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

* [google_service_account](https://www.terraform.io/docs/providers/google/r/google_service_account.html)

## Usage

```hcl
module "grafana" {
  source  = "nlamirault/observability/google//modules/grafana"
  version = "0.0.0"

  project    = var.project
  location   = var.location
}
```

and variables :

```hcl
project  = "...."
location = "...."
```

This module creates :

* a ServiceAccount named *grafana*

## Documentation
