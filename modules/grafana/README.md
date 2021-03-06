# Observability / Grafana

Terraform module which configure grafana resources on Google Cloud.

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
| [google_project_iam_member](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/project_iam_member) |
| [google_service_account](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/service_account) |
| [google_service_account_iam_member](https://registry.terraform.io/providers/hashicorp/google/3.45.0/docs/resources/service_account_iam_member) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| project | The project in which the resource belongs | `string` | n/a | yes |
| service\_account | The Kubernetes service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| email | Service account email |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
