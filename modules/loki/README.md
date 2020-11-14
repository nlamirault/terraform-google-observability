# Observability / Loki

Terraform module which configure Loki resources on Google Cloud.

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

* [google_service_account](https://www.terraform.io/docs/providers/google/r/google_service_account.html)
* [google_storage_bucket](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)
* [google_storage_bucket_iam_member](https://www.terraform.io/docs/providers/google/r/storage_bucket_iam.html)
* [google_bigtable_instance](https://www.terraform.io/docs/providers/google/r/bigtable_instance.html)
* [google_bigtable_instance_iam_member](https://www.terraform.io/docs/providers/google/r/bigtable_instance_iam.html#google_bigtable_instance_iam_member)

## Usage

```hcl
module "loki" {
  source  = "nlamirault/observability/google//modules/loki"
  version = "0.0.0"

  project = var.project
  region  = var.region

  bucket_location      = var.bucket_location
  bucket_storage_class = var.bucket_storage_class
  bucket_labels        = var.bucket_labels
}
```

and variables :

```hcl
project  = "...."
region = "...."

bucket_location = "europe-west1"

bucket_storage_class = "STANDARD"

bucket_labels = {
  customer = "masociete"
  service  = "kubernetes"
  env      = "prod"
  made-by  = "terraform"
}
```

This module creates :

* a ServiceAccount named *grafana-loki*
* a GCS bucket *myproject_name_loki*
* a Bigtable instance *grafana-loki*

## Documentation

## Providers

| Name | Version |
|------|---------|
| google | >= 3.14.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bucket\_labels | Map of labels to apply to the bucket | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| bucket\_location | The bucket location | `string` | n/a | yes |
| bucket\_storage\_class | Bucket storage class. | `string` | `"MULTI_REGIONAL"` | no |
| project | The project in which the resource belongs | `string` | n/a | yes |
| region | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket | Bucket resource (for single use). |
| name | Bucket name (for single use). |
| url | Bucket URL (for single use). |

