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
  version = "4.1.1"

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
  version = "7.4.1"

  project = var.project
  # mode    = "additive"

  # module.service_account.emails_list
  # https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/142
  service_accounts = [
    format("%s@%s.iam.gserviceaccount.com", local.service, var.project),
    format("%s@%s.iam.gserviceaccount.com", var.prometheus_service_account, var.project)
  ]

  bindings = {
    "roles/iam.workloadIdentityUser" = formatlist("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, var.service_account)
  }

  depends_on = [
    module.service_account
  ]
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "3.1.0"

  name            = format("%s-%s", var.project, local.service)
  project_id      = var.project
  location        = var.bucket_location
  storage_class   = var.bucket_storage_class
  labels          = var.bucket_labels
  lifecycle_rules = var.lifecycle_rules

  encryption = var.enable_kms ? {
    default_kms_key_name = keys(module.kms.keys)[0]
  } : null

  # https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/142
  # iam_members = [{
  #   role   = "roles/storage.objectAdmin"
  #   member = format("serviceAccount:%s", module.service_account.email)
  # }]
}

module "iam_storage_buckets" {
  source  = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  version = "7.4.1"

  storage_buckets = [module.bucket.bucket.name]
  # mode            = "additive"

  bindings = {
    # https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/142
    # "roles/storage.objectAdmin" = formatlist("serviceAccount:%s", module.service_account.emails_list)
    "roles/storage.objectAdmin" = [
      format("serviceAccount:%s@%s.iam.gserviceaccount.com", local.service, var.project),
      format("serviceAccount:%s@%s.iam.gserviceaccount.com", var.prometheus_service_account, var.project)
    ]
  }

  depends_on = [
    module.service_account
  ]
}
