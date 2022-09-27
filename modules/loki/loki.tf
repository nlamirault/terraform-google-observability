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

module "workload_identity" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "20.0.0"

  project_id = var.project

  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = local.service
  k8s_sa_name         = var.service_account
  namespace           = var.namespace
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "3.2.0"

  project_id      = var.project
  names           = [local.bucket_name]
  prefix          = local.service
  set_admin_roles = true
  admins          = [format("serviceAccount:%s", module.workload_identity.gcp_service_account_email)]
  versioning = {
    local.bucket_name = true
  }
  encryption_key_names = var.enable_kms ? module.kms.keys : {}
}
