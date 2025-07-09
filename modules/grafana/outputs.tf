
# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

output "email" {
  description = "Service account email for Grafana"
  value       = module.service_account.email
}
