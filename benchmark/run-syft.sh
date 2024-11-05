set -exo pipefail
syft packages dir:$TARGET_PATH --output cyclonedx-json > $SBOM_PATH
