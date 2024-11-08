set -exo pipefail
export VIRTUAL_ENV="$TARGET_VENV"
./node_modules/.bin/cdxgen --type python --output $SBOM_PATH
