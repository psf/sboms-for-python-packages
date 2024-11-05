#!/bin/bash
set -exo pipefail

SCRIPT_DIR="$(dirname -- "$0";)"

export TARGET_PATH="$SCRIPT_DIR/venv"
if [[ ! -d "$TARGET_PATH" ]]; then
  python -m venv "$SCRIPT_DIR/venv"
fi
"$SCRIPT_DIR/venv/bin/python" -m pip install -r "$SCRIPT_DIR/requirements.txt"

for SBOM_GEN in cdxgen syft trivy; do
  export SBOM_PATH="$SCRIPT_DIR/sboms/$SBOM_GEN.cdx.json"

  # Run the SBOM generator tool
  "$SCRIPT_DIR/run-$SBOM_GEN.sh"

  # Format the JSON consistently across all documents.
  python -m json.tool --indent=2 --sort-keys $SBOM_PATH $SBOM_PATH
done