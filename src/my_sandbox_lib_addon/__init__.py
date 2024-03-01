import warnings

from my_sandbox_lib import _version as _lib_version
from my_sandbox_lib_addon import _version as _addon_version


if _lib_version.__version__ != _addon_version.__version__:
    warnings.warn(
        "Version mismatch: "
        f"my-sandbox-lib ({_lib_version.__version__}) "
        "!= "
        f"my-sandbox-lib-addon ({_addon_version.__version__})"
    )
