build_lib_package::
	cd my-sandbox-lib && hatch build

build_lib_addon_package::
	cd my-sandbox-lib-addon && hatch build

clean_build_artifacts::
	rm -rf dist/*

build:: clean_build_artifacts build_lib_package build_lib_addon_package

build_and_publish:: build
	hatch publish --repo $(HATCH_INDEX_REPO) dist

# When updating sources during development without creating new commits,
# the same package version will be used repeatedly, causing some unwanted "caching" in pip.
# I.e. although project.toml was altered ( for example to edit dependecies ),
# pip would still use the cached wheel ( because the version is still the same ).
# We clean the pip cache here for our known packages to workaround such issues.
clean_pip_cache::
	cd src \
	&& pip cache remove my-sandbox-lib \
	&& pip cache remove my_sandbox_lib \
	&& pip cache remove my-sandbox-lib-addon \
	&& pip cache remove my_sandbox_lib_addon \
	&& pip cache remove my-sandbox-lib-suite \
	&& pip cache remove my_sandbox_lib_suite

install_deps:: clean_pip_cache
	cd src \
	&& hatch --verbose env create \
	&& hatch run -- python -c 'import sys; import platform; print(f"Setup python {{platform.python_version()}} environment done: {{sys.executable}}")'

prune_env::
	cd src \
	&& hatch env prune

reset_env:: prune_env install_deps

show_deps::
	cd src \
	&& hatch run pipdeptree

list_outdated_deps::
	cd src \
	&& hatch run -- pip3 list --outdated

test::
	cd src \
	&& hatch run test:cov

format::
	cd src \
	&& hatch run format

lint::
	@# Exit code of pylint encodes found issues, see https://pylint.pycqa.org/en/latest/user_guide/usage/run.html#exit-codes
	@# We want to fail on exitcode mask 0x3 => fatal (0x1) or error messages (0x2)
	cd src \
	&& hatch run test:lint ; if [ "$$(($$? & 0x3))" != "0" ] ; then false ; else true ; fi
