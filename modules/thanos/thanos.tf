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

resource "google_service_account" "thanos" {
  account_id   = local.service_name
  display_name = "Thanos"
  description  = "Created by Terraform"
}

resource "google_storage_bucket_iam_member" "storage_thanos" {
  bucket = google_storage_bucket.thanos.name
  role   = "roles/storage.objectAdmin"
  member = format("serviceAccount:%s", google_service_account.thanos.email)
}

resource "google_project_iam_member" "secret_manager_thanos" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"
  member  = format("serviceAccount:%s", google_service_account.thanos.email)
}

data "google_service_account" "prometheus" {
  account_id = var.prometheus_service_account
}

resource "google_storage_bucket_iam_member" "storage_prometheus" {
  bucket = google_storage_bucket.thanos.name
  role   = "roles/storage.objectAdmin"
  member = format("serviceAccount:%s", data.google_service_account.prometheus.email)
}

resource "google_project_iam_member" "secret_manager_prometheus" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"
  member  = format("serviceAccount:%s", google_service_account.prometheus.email)
}

resource "google_service_account_iam_member" "thanos" {
  for_each           = toset(var.service_account)
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.thanos.name
  member             = format("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, each.key)
}
