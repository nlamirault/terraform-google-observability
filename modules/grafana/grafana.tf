
# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

module "service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.6.0"

  project_id = var.project

  names = [
    local.service
  ]

  project_roles = [
    format("%s=>roles/monitoring.viewer", var.project),
    format("%s=>roles/secretmanager.secretAccessor", var.project),
  ]
}

module "iam" {
  source  = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version = "8.1.0"

  project = var.project

  service_accounts = [
    module.service_account.email
  ]
  mode = "additive"

  bindings = {
    "roles/iam.workloadIdentityUser" = [
      format("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, var.service_account)
    ]
  }
}
