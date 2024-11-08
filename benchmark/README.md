# Benchmarks for SBOM generation tools

Run benchmarks for common open source SBOM generation tools
on typical Python constructs like virtual environments.

Make sure all the tools are installed:

`./install-all.sh`

This requires a local Node installation for cdxgen.
Then you can run the benchmarks:

`$ ./run-all.sh`

and inspect the results under `sboms/`.

Some generators only support reading from a `requirements.txt` file
while some only support reading from a virtual environment. Syft supports
scanning both sources but gives different results.
