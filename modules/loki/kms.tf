
# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "4.1.0"

  count = var.enable_kms ? 1 : 0

  project_id     = var.project
  location       = var.keyring_location
  keyring        = local.service
  keys           = var.keys
  set_owners_for = var.keys
  owners         = var.owners

  encrypters = [
    data.google_storage_project_service_account.gcs_account.email_address
  ]
  decrypters = [
    data.google_storage_project_service_account.gcs_account.email_address
  ]

  labels = var.kms_labels
}
