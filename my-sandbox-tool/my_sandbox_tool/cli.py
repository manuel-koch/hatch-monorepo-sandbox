#!/usr/bin/env python3
from my_sandbox_lib.func import library_function
from my_sandbox_lib_addon.addon_func import library_addon_function


def main():
    library_function()
    library_addon_function()


if __name__ == "__main__":
    main()
