#!/bin/bash

set -exo pipefail

CDXGEN_VERSION="10.11.0"
SYFT_VERSION="1.16.0"
TRIVY_VERSION="0.57.0"

node --version
npm install --verbose "@cyclonedx/cdxgen@${CDXGEN_VERSION}"

wget "https://github.com/anchore/syft/releases/download/v${SYFT_VERSION}/syft_${SYFT_VERSION}_linux_amd64.tar.gz"
tar -xzvf  "syft_${SYFT_VERSION}_linux_amd64.tar.gz" syft
rm "syft_${SYFT_VERSION}_linux_amd64.tar.gz"
chmod a+x ./syft

wget "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz"
tar -xzvf "trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz" trivy
rm "trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz"
chmod a+x ./trivy
