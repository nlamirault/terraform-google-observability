# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

resource "google_service_account" "tempo" {
  account_id   = local.service_name
  display_name = "Tempo"
  description  = "Created by Terraform"
}

resource "google_storage_bucket" "tempo" {
  name          = local.name
  location      = var.bucket_location
  storage_class = var.bucket_storage_class
  labels        = var.bucket_labels

  encryption {
    default_kms_key_name = google_kms_crypto_key.tempo.name
  }
}

resource "google_storage_bucket_iam_member" "tempo" {
  bucket = google_storage_bucket.tempo.name
  role   = "roles/storage.objectAdmin"
  member = format("serviceAccount:%s", google_service_account.tempo.email)
}

resource "google_service_account_iam_member" "tempo" {
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.tempo.name
  member             = format("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, var.service_account)
}
