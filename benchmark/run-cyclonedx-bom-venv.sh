set -exo pipefail
cyclonedx-py environment \
  --of JSON --sv 1.6 -o "$SBOM_PATH" \
  --PEP-639 --gather-license-texts \
  --pyproject "$TARGET_PYPROJECT" \
  "$TARGET_VENV"
