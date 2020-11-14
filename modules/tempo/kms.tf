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

resource "google_kms_key_ring" "tempo" {
  name     = local.service_name
  location = "global"
}

resource "google_kms_crypto_key" "tempo" {
  name            = local.service_name
  key_ring        = google_kms_key_ring.tempo.id
  rotation_period = "100000s"

  #   lifecycle {
  #     prevent_destroy = true
  #   }
}