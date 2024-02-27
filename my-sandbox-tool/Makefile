install_deps::
	hatch --verbose env create \
    && hatch run -- python -c 'import sys; import platform; print(f"Setup python {{platform.python_version()}} environment done: {{sys.executable}}")'

prune_env::
	hatch env prune

reset_env:: prune_env install_deps
