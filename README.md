# Software Bill-of-Materials for Python distributions

## Terminology

This repository uses terminology consistent with the [Python Packaging User Guide Glossary](https://packaging.python.org/en/latest/glossary/).
Note for non-Python package users: this terminology may be different compared to other software ecosystems,
please be aware of these differences when reading and contributing.

## Motivation

Software Bill-of-Materials documents (SBOMs) are a technology and ecosystem-agnostic
format for describing software composition, provenance, and other metadata. SBOMs
are required by recent software security regulations, like the [Secure Software Development Framework](https://csrc.nist.gov/Projects/ssdf) (SSDF)
and the [Cyber Resilience Act](https://digital-strategy.ec.europa.eu/en/policies/cyber-resilience-act) (CRA).
Due to their inclusion in these regulations, the demand for SBOM documents of open source projects is expected to be high.
For example, the Tennessee Valley Authority has already begun attempting to collect SBOM documents
from open source projects like CPython.

Python distributions are particularly affected by the "[phantom dependency](https://www.endorlabs.com/learn/dependency-resolution-in-python-beware-the-phantom-dependency)" problem,
where software that isn't written in Python are included in Python distributions
for many reasons, such as ease of installation and compatibility with standards:

* Python serves scientific, data, and machine-learning use-cases which use compiled or non-Python languages like Rust, C, C++, Fortran, JavaScript, and others.
* The Python wheel format is preferred by users due to the ease-of-installation. No code is executed during the installation step, only extracting the archive.
* The Python wheel format requires bundling shared compiled libraries without a method to encode metadata about these libraries.

This software can't be described accurately using Python package metadata and so
is likely to be missed by software composition analysis (SCA) software which can mean
vulnerable software components aren't reported accurately.

## Rationale

Attempting to adopt every field offered by SBOM standards into Python core metadata would result in an explosion of
new core metadata fields including needing to keep up-to-date as
SBOM standards continue to evolve to suit new needs in that space.

This standard also doesn't aim to replace Python core metadata with SBOMs, instead
focusing on the SBOM information being supplemental to core metadata.
Core metadata fields MUST be used as the authoritative location for information
about a Python distribution itself and included SBOMs MUST only contain information
about dependencies included in the distribution archive OR information
about the software in the distribution that can't be encoded into core metadata
but is relevant for the SBOM use-case (such as, "software identifier", "purpose", "support level", etc).

## Proposal

Today there is no method to encode information for cross-language/ecosystem software
dependencies into Python distribution metadata. This project proposes using SBOM formats
for this purpose and allowing SBOM documents to be included in Python distributions archives
to self-describe software within those distribution archives.

The proposal would require:

### Survey of Python packages, Python package tools, and SBOM tooling

Survey Python package tools, answer the questions "Can these tools adopt this standard?" "How difficult is creating quality SBOM information for Python projects?"

* Python packages using non-Python dependencies (numpy, pandas, jupyter, cryptography, pydantic)
* Build backends supporting cross-ecosystem software ([setuptools](https://github.com/pypa/setuptools), [Maturin](https://github.com/PyO3/maturin))
* Wheel processing tools for vendoring dependencies ([auditwheel](https://github.com/pypa/auditwheel), [repairwheel](https://github.com/jvolkman/repairwheel), [delocate](https://github.com/matthew-brett/delocate), [delvewheel](https://github.com/adang1345/delvewheel))
* Tools for vendoring Python dependencies ([vendoring](https://github.com/pradyunsg/vendoring))
* Runtimes for building wheels ([cibuildwheel](https://github.com/pypa/cibuildwheel), [multibuild](https://github.com/multi-build/multibuild))

Survey SBOM tools and standards, answer the question: "how useful is the information encoded by this standard?"
Using popular SBOM generation tools, can SBOMs be generated to meet the following regulations?

* [Cyber Resilience Act](https://digital-strategy.ec.europa.eu/en/library/cyber-resilience-act) (CRA)
* [NIST Secure Software Development Framework](https://csrc.nist.gov/Projects/ssdf) (SSDF)
* [NTIA Minimum Elements For a Software Bill of Materials](https://www.ntia.gov/report/2021/minimum-elements-software-bill-materials-sbom) (rev3 from CISA)

The survey will inform whether this proposal can be adopted by these tools and how useful this standard would be to downstream consumers.
Some of this survey will come in the form of a pre-PEP and PEP discussion of the subproject below.

### New standards (PEP) for encoding SBOM information

This subproject will require the above subproject to be complete to be "ready for submission" to be reviewed and approved,
but is not blocked on starting the draft PEP and discussion process.

* New core metadata field: `Sbom-File` for specifying the location(s) of one or more SBOM files in a distribution. New package metadata version for the new field.
* New directory for containing SBOM files (`/.dist-info/sboms/`) in Python distributions and installed locations.
  This directory will be similar to the [`/.dist-info/licenses/` directory specified in PEP 639](https://peps.python.org/pep-0639/#license-files-in-project-formats).
* How to self-reference software within a Python distribution as an SBOM component.
* Provide all examples using common SBOM standards like CycloneDX and SPDX. Provide no preference to either standard.
* Set of filtering requirements to add to popular package indexes like PyPI to ensure other tools are adhering to standards.
* Adoption by two build backends/tools and PyPI.

### Golden examples for SBOM tool developers

This subproject aims to provide high-quality calibration materials
for SBOM tool developers. This subproject can be worked on concurrently
to the above two subprojects and then updated later once the above PEP is accepted.

* Create an informational PEP on how to transform Python distribution metadata and included SBOM documents into one SBOM document
  for an installed Python distribution.
* Create a list of example projects and "golden" SBOMs against complex Python distributions (pip, numpy, pandas, pydantic, etc)
* Test these examples against SBOM generation tools for conformance.

## License

This repository is placed in the public domain or under the [CC0-1.0-Universal license](https://creativecommons.org/publicdomain/zero/1.0/), whichever is more permissive.
