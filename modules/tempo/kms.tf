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

resource "google_kms_key_ring" "tempo" {
  count    = var.enable_kms ? 1 : 0
  name     = local.service_name
  location = var.keyring_location
}

resource "google_kms_crypto_key" "tempo" {
  count           = var.enable_kms ? 1 : 0
  name            = local.service_name
  key_ring        = google_kms_key_ring.tempo[0].id
  rotation_period = "100000s"

  #   lifecycle {
  #     prevent_destroy = true
  #   }
}

data "google_storage_project_service_account" "gcs_account" {
}

resource "google_kms_crypto_key_iam_binding" "binding" {
  count         = var.enable_kms ? 1 : 0
  crypto_key_id = google_kms_crypto_key.tempo[0].id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [format("serviceAccount:%s", data.google_storage_project_service_account.gcs_account.email_address)]
}
