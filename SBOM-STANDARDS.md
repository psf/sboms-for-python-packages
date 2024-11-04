# SBOM standards and formats

The most popular SBOM standards are [CycloneDX](https://cyclonedx.org/) and [SPDX](https://spdx.dev/).
One of the project goals is to support popular standards without any preference for one format over another.
Because these SBOM standards are most popular, we can add specific requirements around their use to ensure conformity.

Tools which aim to read or manipulate SBOM documents included in Python packages MUST be able to handle both CycloneDX and SPDX SBOMs.
Note that this typically only applies to end-users and their tooling, not Python package build backends or middlewares like auditwheel.
Tools that are creating their own SBOM documents for Python packages can use any standard, as they aren't reading existing SBOM documents.

SBOM documents included in Python packages MUST use JSON for CycloneDX and SPDX.
This is due to JSON manipulation being available in the Python standard library,
supported by both CycloneDX and SPDX, and being generally simpler
than other formats like XML. Other SBOM standards SHOULD use JSON, if supported by that standard.

Standard file extensions SHOULD be used for SBOM documents included in Python packages.
For SPDX the extension is `.spdx.json` and for CycloneDX the extension is `.cdx.json`.
Processing SBOM documents MUST be able to handle SBOM files which don't use these
extensions but are nonetheless SPDX/CycloneDX SBOMs.
