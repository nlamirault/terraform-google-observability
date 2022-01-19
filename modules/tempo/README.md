# Observability / Loki

Terraform module which configure Loki resources on Google Cloud.

## Usage

```hcl
module "tempo" {
  source  = "nlamirault/observability/google//modules/tempo"
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
  service  = "tempo"
  env      = "prod"
  made-by  = "terraform"
}
```

## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | 3.1.0 |
| <a name="module_iam_service_accounts"></a> [iam\_service\_accounts](#module\_iam\_service\_accounts) | terraform-google-modules/iam/google//modules/service_accounts_iam | 7.4.0 |
| <a name="module_iam_storage_buckets"></a> [iam\_storage\_buckets](#module\_iam\_storage\_buckets) | terraform-google-modules/iam/google//modules/storage_buckets_iam | 7.4.0 |
| <a name="module_kms"></a> [kms](#module\_kms) | terraform-google-modules/kms/google | 2.1.0 |
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | terraform-google-modules/service-accounts/google | 4.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_storage_project_service_account.gcs_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_labels"></a> [bucket\_labels](#input\_bucket\_labels) | Map of labels to apply to the bucket | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | The bucket location | `string` | n/a | yes |
| <a name="input_bucket_storage_class"></a> [bucket\_storage\_class](#input\_bucket\_storage\_class) | Bucket storage class. | `string` | `"MULTI_REGIONAL"` | no |
| <a name="input_enable_kms"></a> [enable\_kms](#input\_enable\_kms) | Enable custom KMS key | `bool` | n/a | yes |
| <a name="input_keyring_location"></a> [keyring\_location](#input\_keyring\_location) | The KMS keyring location | `string` | n/a | yes |
| <a name="input_keys"></a> [keys](#input\_keys) | Key names. | `list(string)` | `[]` | no |
| <a name="input_kms_labels"></a> [kms\_labels](#input\_kms\_labels) | Map of labels to apply to the KMS resources | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | The bucket's Lifecycle Rules configuration. | <pre>list(object({<br>    # Object with keys:<br>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br>    action = any<br><br>    # Object with keys:<br>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br>    # - matches_storage_class - (Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br>    condition = any<br>  }))</pre> | <pre>[<br>  {<br>    "action": {<br>      "type": "Delete"<br>    },<br>    "condition": {<br>      "age": 365,<br>      "with_state": "ANY"<br>    }<br>  }<br>]</pre> | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_owners"></a> [owners](#input\_owners) | List of comma-separated owners for each key declared in set\_owners\_for. | `list(string)` | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | The project in which the resource belongs | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The Kubernetes service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Bucket resource (for single use). |
| <a name="output_email"></a> [email](#output\_email) | Service account email |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
