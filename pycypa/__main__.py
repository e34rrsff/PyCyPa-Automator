# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

# main() doesn't need to be defined for scripts that only contain functions,
# such as scripts under .../<distro-codename/windows-release>/

import sys
import importlib
import platform

def linux():
    import distro
    try:
        system = importlib.import_module( distro.codename() )
    except ModuleNotFoundError:
        print(  'Module "' + distro.codename() + '" not found.\n'+
                'The host system is probably not running the same',
                'release codename as the compiled target.' )
        sys.exit()

    system.main()

def main():
    linux()

if __name__ == '__main__':
    main()
