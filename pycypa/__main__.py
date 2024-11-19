# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

import sys
import importlib
import platform

def importLinuxRelease():
    import distro
    
    # IMPORTANT CHANGE "jammy" TO distro.codename() AFTER DONE TESTING
    global systemRelease
    systemVersion = importlib.import_module( 'linux.' + 'jammy' )

def main():
    linux()

if __name__ == '__main__':
    main()
