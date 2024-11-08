set -exo pipefail
./trivy fs --format cyclonedx --output $SBOM_PATH $TARGET_REQS
