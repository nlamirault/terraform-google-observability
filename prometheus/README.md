# Observability / Prometheus

Terraform module which configure Prometheus resources on Google Cloud.

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

* [google_service_account](https://www.terraform.io/docs/providers/google/r/google_service_account.html)
* [google_project_iam_member](https://www.terraform.io/docs/providers/google/r/google_project_iam.html#google_project_iam_member)

## Usage

```hcl
module "prometheus" {
  project = var.project
  region  = var.region

  account_id_prometheus   = var.account_id_prometheus
  display_name_prometheus = var.display_name_prometheus
}
```

and variables :

```hcl
project  = "...."
region = "...."

account_id_prometheus   = "prometheus"
display_name_prometheus = "Prometheus for Portefaix"
}
```

This module creates :

* a ServiceAccount

## Documentation
