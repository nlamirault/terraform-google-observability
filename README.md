# Observability components into Google Cloud Platform

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/10882/badge)](https://www.bestpractices.dev/en/projects/10882)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/nlamirault/terraform-google-observability/badge)](https://securityscorecards.dev/viewer/?uri=github.com/nlamirault/terraform-google-observability)
[![SLSA 3](https://slsa.dev/images/gh-badge-level3.svg)](https://slsa.dev)

This module consists of the following submodules:

- [prometheus](https://github.com/nlamirault/terraform-google-observability/tree/master/modules/prometheus)
- [thanos](https://github.com/nlamirault/terraform-google-observability/tree/master/modules/thanos)
- [loki](https://github.com/nlamirault/terraform-google-observability/tree/master/modules/loki)
- [tempo](https://github.com/nlamirault/terraform-google-observability/tree/master/modules/tempo)

For GKE, enable [Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity)

See more details in each module's README.

## SLSA

All _artifacts_ provided by this repository meet [SLSA L3](https://slsa.dev/spec/v1.0/levels#build-l3)

### Verify SLSA provenance using the Github CLI

```shell
$ gh attestation verify oci://ghcr.io/nlamirault/modules/terraform-google-observability:v6.0.0 --repo nlamirault/terraform-google-observability

```

### Verify SLSA provenance using Cosign

```shell
$ cosign verify-attestation \
  --type slsaprovenance \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp '^https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v[0-9]+.[0-9]+.[0-9]+$' \
  ghcr.io/nlamirault/modules/terraform-google-observability:v6.0.0@sha256:006e0f3fdc4071db667cef0b922de39addbb4996765fb76213cfb1b03cbabf05

```

## OCI

You could discover all the referrers of manifest with annotations, displayed in a tree view:

```shell
$ oras discover --format tree ghcr.io/nlamirault/modules/terraform-google-observability:v7.0.0

```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

[Apache 2.0 License](./LICENSE)
