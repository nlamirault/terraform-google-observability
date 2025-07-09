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
$ gh attestation verify oci://ghcr.io/nlamirault/modules/terraform-google-observability:v7.0.0 --repo nlamirault/terraform-google-observability
Loaded digest sha256:fadc23f3249a991d451c943ad834533630368596bcd7a41d34ec7aa95d552e14 for oci://ghcr.io/nlamirault/modules/terraform-google-observability:v7.0.0
Loaded 1 attestation from GitHub API
✓ Verification succeeded!

sha256:fadc23f3249a991d451c943ad834533630368596bcd7a41d34ec7aa95d552e14 was attested by:
REPO                                       PREDICATE_TYPE                  WORKFLOW
nlamirault/terraform-google-observability  https://slsa.dev/provenance/v1  .github/workflows/terraform-oci.yaml@refs/tags/v7.0.0
```

### Verify SLSA provenance using Cosign

```shell
$ cosign verify-attestation \
  --type slsaprovenance \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp '^https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v[0-9]+.[0-9]+.[0-9]+$' \
  ghcr.io/nlamirault/modules/terraform-google-observability:v7.0.0@sha256:fadc23f3249a991d451c943ad834533630368596bcd7a41d34ec7aa95d552e14

Verification for ghcr.io/nlamirault/modules/terraform-google-observability:v7.0.0@sha256:fadc23f3249a991d451c943ad834533630368596bcd7a41d34ec7aa95d552e14 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates
Certificate subject: https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v2.1.0
Certificate issuer URL: https://token.actions.githubusercontent.com
GitHub Workflow Trigger: push
GitHub Workflow SHA: 47930b3d2c85bbf87f06bcc358a71a454ba1e75e
GitHub Workflow Name: Terraform / OCI
GitHub Workflow Repository: nlamirault/terraform-google-observability
GitHub Workflow Ref: refs/tags/v7.0.0
...
```

## OCI

You could discover all the referrers of manifest with annotations, displayed in a tree view:

```shell
$ oras discover --format tree ghcr.io/nlamirault/modules/terraform-google-observability:v7.0.0
ghcr.io/nlamirault/modules/terraform-google-observability@sha256:fadc23f3249a991d451c943ad834533630368596bcd7a41d34ec7aa95d552e14
└── application/vnd.dev.sigstore.bundle.v0.3+json
    └── sha256:8b374415fefd176220707c7e079e76a54b29f724b8c6ad69a285228e34ee1c7f
```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

[Apache 2.0 License](./LICENSE)
