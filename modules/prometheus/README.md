# Observability / Prometheus

Terraform module which configure Prometheus resources on Google Cloud.

## Usage

```hcl
module "prometheus" {
  source  = "nlamirault/observability/google//modules/prometheus"
  version = "0.0.0"

  project = var.project
  region  = var.region
}
```

and variables :

```hcl
project  = "...."
region = "...."
}
```

## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam"></a> [iam](#module\_iam) | terraform-google-modules/iam/google//modules/service_accounts_iam | 7.3.0 |
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | terraform-google-modules/service-accounts/google | 4.0.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project in which the resource belongs | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The Kubernetes service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_email"></a> [email](#output\_email) | Service account email |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
