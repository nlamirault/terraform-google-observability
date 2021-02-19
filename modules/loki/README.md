# Observability / Loki

Terraform module which configure Loki resources on Google Cloud.

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
  service  = "loki"
  env      = "prod"
  made-by  = "terraform"
}
```

## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| google | >= 3.45.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.45.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google_kms_crypto_key](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/kms_crypto_key) |
| [google_kms_crypto_key_iam_binding](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/kms_crypto_key_iam_binding) |
| [google_kms_key_ring](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/kms_key_ring) |
| [google_service_account](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/service_account) |
| [google_service_account_iam_member](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/service_account_iam_member) |
| [google_storage_bucket](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/storage_bucket) |
| [google_storage_bucket_iam_member](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/storage_bucket_iam_member) |
| [google_storage_project_service_account](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/data-sources/storage_project_service_account) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_labels | Map of labels to apply to the bucket | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| bucket\_location | The bucket location | `string` | n/a | yes |
| bucket\_storage\_class | Bucket storage class. | `string` | `"MULTI_REGIONAL"` | no |
| keyring\_location | The KMS keyring location | `string` | n/a | yes |
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| project | The project in which the resource belongs | `string` | n/a | yes |
| service\_account | The Kubernetes service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket | Bucket resource (for single use). |
| email | Service account email |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
