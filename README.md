# hatch-monorepo-sandbox

This repo is a sandbox to try out using `hatch` to publish multiple
related python packages from a single monorepo.

Main idea:
- have a library that contains production code
- have an auxiliary library that contains non-production code, e.g. test factories, debug helpers asf.
- version of auxiliary lib matches version of production lib
- when testing the production library, use the auxiliary library too

Structure of this repo:
- `my-sandbox-lib` holds the project configuration for the production library.
- `my-sandbox-lib-addon` holds the project configuration for the auxiliary library.
- `my-sandbox-tool` an arbitrary project configuration that makes use of `my-sandbox-lib` & `my-sandbox-lib-addon`.
  I.e. this is how other projects would typically use `my-sandbox-lib` & `my-sandbox-lib-addon`.
- `src` holds the source code
  - project configuration for an environment that combines all of the following 
  - production library `my-sandbox-lib`
  - auxiliary library `my-sandbox-lib-addon`
  - test code `tests`

# Development

Typical development activity ( updating the libs with new functionality, adding bugfixes )
would involve commands from the repo root directory, like
- `make reset_env` to rebuild the python environment.
- `make format` to format sources of the libs & test code.
- `make lint` to lint sources of the libs & test code.
- `make test` to run tests on libs.

Once development is finished, the updated libs can be build & published, using
- `make build_lib_package` to build production library `my-sandbox-lib`.
- `make build_lib_addon_package` to build auxiliary library `my-sandbox-lib-addon`.
- `make build_and_publish` to build the libs and publish them to a PyPi repository.