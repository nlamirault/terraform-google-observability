# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

module "service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.5.4"

  project_id = var.project

  names = [
    format("%s-sa", local.service)
  ]

  project_roles = [
    format("%s=>roles/secretmanager.secretAccessor", var.project),
  ]
}

module "iam_service_accounts" {
  source  = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version = "8.1.0"

  project = var.project
  mode    = "additive"

  service_accounts = [
    # https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/142
    # module.service_account.email
    format("%s@%s.iam.gserviceaccount.com", local.service, var.project),
  ]

  bindings = {
    "roles/iam.workloadIdentityUser" = [
      format("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, var.service_account)
    ]
  }
}

module "iam_storage_buckets" {
  source  = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  version = "8.1.0"

  storage_buckets = [module.bucket.bucket.name]
  mode            = "authoritative"

  bindings = {
    "roles/storage.objectAdmin" = [
      # https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/142
      format("serviceAccount:%s@%s.iam.gserviceaccount.com", local.service, var.project),
    ]
  }
}
