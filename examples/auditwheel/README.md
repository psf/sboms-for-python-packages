# Auditwheel with support for SBOMs

This example project shows how SBOMs can be added to Python wheels
alongside bundled shared libraries. Frequently shared libraries are
taken from the operating systems' package manager, especially when
being built in a particular build environment like cibuildwheel.

The file `Pillow-10.0.0-cp312-cp312-manylinux_2_28_x86_64.whl`
contains an SBOM file `Pillow-10.0.0.dist-info/auditwheel.cdx.json`.
This file is annotated in metadata (`Pillow-10.0.0.dist-info/METADATA`)
with the `Sbom-File` field.
