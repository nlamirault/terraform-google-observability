

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

output "bucket" {
  description = "Bucket resource (for single use)."
  value       = module.bucket.bucket
}

output "email" {
  description = "Service account email"
  value       = module.service_account.email
}
