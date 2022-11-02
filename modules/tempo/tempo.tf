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

module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "2.2.1"

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

module "workload_identity" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "23.1.0"

  project_id          = var.project
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = local.service
  k8s_sa_name         = var.service_account
  namespace           = var.namespace
  roles = [
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
    "storage.buckets.get",
    "roles/secretmanager.secretAccessor"
  ]
}

#tfsec:ignore:google-storage-bucket-encryption-customer-key
module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "3.4.0"

  project_id      = var.project
  names           = [local.bucket_name]
  prefix          = local.service
  set_admin_roles = true
  admins          = [format("serviceAccount:%s", module.workload_identity.gcp_service_account_email)]
  versioning = {
    local.bucket_name = true
  }
  encryption_key_names = var.enable_kms ? module.kms.keys : {}
  location             = var.bucket_location
  storage_class        = var.bucket_storage_class
  labels               = var.bucket_labels
  lifecycle_rules      = var.lifecycle_rules
}
