
# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

# Loki

variable "project" {
  type        = string
  description = "The project in which the resource belongs"
}

variable "bucket_location" {
  type        = string
  description = "The bucket location"
}

variable "bucket_storage_class" {
  type        = string
  description = "Bucket storage class."
  default     = "MULTI_REGIONAL"
}

variable "bucket_labels" {
  description = "Map of labels to apply to the bucket"
  type        = map(string)
  default = {
    "made-by" = "terraform"
  }
}

variable "lifecycle_rules" {
  description = "The bucket's Lifecycle Rules configuration."
  type = list(object({
    # Object with keys:
    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.
    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.
    action = any

    # Object with keys:
    # - age - (Optional) Minimum age of an object in days to satisfy this condition.
    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.
    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".
    # - matches_storage_class - (Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.
    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.
    condition = any
  }))
  default = [{
    action = {
      type = "Delete"
    }
    condition = {
      age        = 365
      with_state = "ANY"
    }
  }]
}


# Workload Identity

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace"
}

variable "service_account" {
  type        = string
  description = "The Kubernetes service account"
}

# KMS

variable "enable_kms" {
  type        = bool
  description = "Enable custom KMS key"
}

variable "keyring_location" {
  type        = string
  description = "The KMS keyring location"
}

variable "owners" {
  description = "List of comma-separated owners for each key declared in set_owners_for."
  type        = list(string)
  default     = []
}

variable "keys" {
  description = "Key names."
  type        = list(string)
  default     = []
}

variable "kms_labels" {
  description = "Map of labels to apply to the KMS resources"
  type        = map(string)
  default = {
    "made-by" = "terraform"
  }
}
