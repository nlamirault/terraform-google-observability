# Observability / Thanos

Terraform module which configure Thanos resources on Google Cloud.

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

* [google_service_account](https://www.terraform.io/docs/providers/google/r/google_service_account.html)
* [google_storage_bucket](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)
* [google_storage_bucket_iam_member](https://www.terraform.io/docs/providers/google/r/storage_bucket_iam.html)

## Usage

```hcl
module "thanos" {
  source  = "nlamirault/observability/google/thanos"
  version = "0.0.0"

  project    = var.project
  location   = var.location

  account_id_thanos   = var.account_id_thanos
  display_name_thanos = var.display_name_thanos
  storage_class       = var.storage_class
  labels              = var.labels
}
```

and variables :

```hcl
project  = "...."
location = "...."

account_id_thanos   = "thanos"
display_name_thanos = "Prometheus for Portefaix"

storage_class = "STANDARD"

labels = {
  customer = "my-customer"
  service  = "kubernetes"
  env      = "preprod"
  made-by  = "terraform"
}
```

This module creates :

* a ServiceAccount named *thanos*
* a GCS bucket *myproject_name_thanos*

## Documentation

### Providers

| Name | Version |
|------|---------|
| google | ~> 3 |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| labels | Map of labels to apply to the bucket | `map` | n/a | yes |
| location | The bucket location | `string` | n/a | yes |
| project | The project in which the resource belongs | `string` | n/a | yes |
| storage\_class | Bucket storage class. | `string` | `"MULTI_REGIONAL"` | no |

### Outputs

| Name | Description |
|------|-------------|
| bucket | Bucket resource (for single use). |
| name | Bucket name (for single use). |
| url | Bucket URL (for single use). |
