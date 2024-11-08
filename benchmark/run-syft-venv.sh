set -exo pipefail
syft packages dir:$TARGET_VENV --output cyclonedx-json > $SBOM_PATH
