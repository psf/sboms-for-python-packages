set -exo pipefail
cyclonedx-py requirements \
  --of JSON --sv 1.6 -o "$SBOM_PATH" \
  --pyproject "$TARGET_PYPROJECT" \
  "$TARGET_REQS"
