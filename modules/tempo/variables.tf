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

# Loki

variable project {
  type = string
}

variable bucket_location {
  type        = string
  description = "The bucket location"
}

variable bucket_storage_class {
  description = "Bucket storage class."
  default     = "MULTI_REGIONAL"
}

variable bucket_labels {
  description = "Map of labels to apply to the bucket"
  type        = map(string)
  default = {
    "made-by" = "terraform"
  }
}

# Workload Identity

variable namespace {
  type        = string
  description = "The Kubernetes namespace"
}

variable service_account {
  type        = string
  description = "The Kubernetes service account"
}

# KMS

variable keyring_location {
  type        = string
  description = "The KMS keyring location"
}
