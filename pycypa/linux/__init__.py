# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

# main() doesn't need to be defined for scripts that only contain functions,
# such as scripts under .../<distro-codename/windows-release>/

import importlib
import distro
import jammy

codename = distro.codename()

def main():
    print( 'Successfully imported the "linux" module' )
    #importlib.import_module( codename )
    jammy.main()
