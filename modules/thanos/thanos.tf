# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module "service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.0.3"

  project_id = var.project

  names = [
    local.service,
    var.prometheus_service_account
  ]

  project_roles = [
    format("%s=>roles/secretmanager.secretAccessor", var.project),
  ]
}

module "iam_service_accounts" {
  source  = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version = "7.3.0"

  project = var.project
  mode    = "authoritative"

  service_accounts = [
    module.service_account.email
  ]

  bindings = {
    "roles/iam.workloadIdentityUser" = formatlist("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, var.service_account)
  }
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "3.0.0"

  name            = format("%s-%s", var.project, local.service)
  project_id      = var.project
  location        = var.bucket_location
  storage_class   = var.bucket_storage_class
  labels          = var.bucket_labels
  lifecycle_rules = var.lifecycle_rules

  encryption = var.enable_kms ? {
    default_kms_key_name = google_kms_crypto_key.thanos[0].name
  } : null

  # https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/142
  # iam_members = [{
  #   role   = "roles/storage.objectAdmin"
  #   member = format("serviceAccount:%s", module.service_account.email)
  # }]
}

module "iam_storage_buckets" {
  source  = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  version = "7.3.0"

  for_each = module.service_account.emails

  storage_buckets = [module.bucket.bucket.name]
  mode            = "authoritative"

  bindings = {
    "roles/storage.objectAdmin" = [
      format("serviceAccount:%s", each.value) #module.service_account.email)
    ]
  }
}

# resource "google_service_account" "thanos" {
#   account_id   = local.service_name
#   display_name = "Thanos"
#   description  = "Created by Terraform"
# }

# resource "google_storage_bucket_iam_member" "storage_thanos" {
#   bucket = google_storage_bucket.thanos.name
#   role   = "roles/storage.objectAdmin"
#   member = format("serviceAccount:%s", google_service_account.thanos.email)
# }

# resource "google_project_iam_member" "secret_manager_thanos" {
#   project = var.project
#   role    = "roles/secretmanager.secretAccessor"
#   member  = format("serviceAccount:%s", google_service_account.thanos.email)
# }

# resource "google_service_account" "prometheus_sidecar" {
#   account_id   = var.prometheus_service_account
#   display_name = "Prometheus Thanos sidecar"
#   description  = "Created by Terraform"
# }

# resource "google_storage_bucket_iam_member" "storage_prometheus" {
#   bucket = google_storage_bucket.thanos.name
#   role   = "roles/storage.objectAdmin"
#   member = format("serviceAccount:%s", google_service_account.prometheus_sidecar.email)
# }

# resource "google_project_iam_member" "secret_manager_prometheus" {
#   project = var.project
#   role    = "roles/secretmanager.secretAccessor"
#   member  = format("serviceAccount:%s", google_service_account.prometheus_sidecar.email)
# }

# resource "google_service_account_iam_member" "thanos" {
#   for_each           = toset(var.service_account)
#   role               = "roles/iam.workloadIdentityUser"
#   service_account_id = google_service_account.thanos.name
#   member             = format("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, each.key)
# }
