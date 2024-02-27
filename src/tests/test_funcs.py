from unittest import TestCase

from my_sandbox_lib.func import library_function
from my_sandbox_lib_addon.addon_func import library_addon_function


class Test(TestCase):

    def test_func(self):
        library_function()

    def test_addon_func(self):
        library_addon_function()
