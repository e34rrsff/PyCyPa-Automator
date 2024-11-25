# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

import platform
from importlib import import_module

def main():
    system = import_module( platform.system().lower() )
    system.run()

if __name__ == '__main__':
    main()
