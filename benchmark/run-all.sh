#!/bin/bash
set -exo pipefail

SCRIPT_DIR="$(realpath "$(dirname -- "$0";)")"
SBOM_DIR="$SCRIPT_DIR/sboms"

# Some SBOM generators support only venvs, some only requirements.txts
export TARGET_VENV=$(realpath "$SCRIPT_DIR/venv")
export TARGET_REQS=$(realpath "$SCRIPT_DIR/requirements.txt")
export TARGET_PYPROJECT=$(realpath "$SCRIPT_DIR/pyproject.toml")

for SBOM_GEN in cdxgen cyclonedx-bom-reqs cyclonedx-bom-venv syft-reqs syft-venv trivy; do
  export SBOM_PATH="$SBOM_DIR/$SBOM_GEN.cdx.json"

  # Run the SBOM generator tool
  "$SCRIPT_DIR/run-$SBOM_GEN.sh"

  # Format the JSON consistently across all documents.
  python -m json.tool --indent=2 --sort-keys $SBOM_PATH $SBOM_PATH
done

# Remove paths which might vary across runs.
find $SBOM_DIR -type f -print0 | xargs -0 sed -i "s|$SCRIPT_DIR||g"
