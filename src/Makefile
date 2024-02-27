HATCH_INDEX_REPO:=$(if ${HATCH_INDEX_REPO},${HATCH_INDEX_REPO},https://item24.jfrog.io/artifactory/api/pypi/ds-pypi)
export PIP_CONFIG_FILE:=${HOME}/.config/pip/item-jfrog-pip.conf

build_and_publish_package::
	hatch build --clean
	hatch publish --repo $(HATCH_INDEX_REPO)

install_deps::
	hatch --verbose env create
	hatch run -- python -c 'import sys; import platform; print(f"Setup python {{platform.python_version()}} environment done: {{sys.executable}}")'

prune_env::
	hatch env prune

reset_env:: prune_env install_deps

show_deps::
	hatch run pipdeptree

list_outdated_deps::
	hatch run -- pip3 list --outdated

test::
	hatch run test:cov

format::
	hatch run format

lint::
	@# Exit code of pylint encodes found issues, see https://pylint.pycqa.org/en/latest/user_guide/usage/run.html#exit-codes
	@# We want to fail on exitcode mask 0x3 => fatal (0x1) or error messages (0x2)
	hatch run test:lint ; if [ "$$(($$? & 0x3))" != "0" ] ; then false ; else true ; fi
