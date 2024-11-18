# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

# main() doesn't need to be defined for scripts that only contain functions,
# such as scripts under .../<distro-codename/windows-release>/

import importlib
import platform

def congregateScripts():
    # Get filenames of scripts under the directory of current platform name
    # (system = importlib jargon) = import linux/windows,
    # system.main() = <windows/linux>/__init__.py's main function
    system = importlib.import_module(platform.system().lower())
    system.main()

def main():
    # Write your code here
    congregateScripts()

if __name__ == '__main__':
    main()
