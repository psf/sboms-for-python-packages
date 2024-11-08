set -exo pipefail
syft packages file:$TARGET_REQS --output cyclonedx-json > $SBOM_PATH
