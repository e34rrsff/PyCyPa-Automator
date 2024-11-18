#!/usr/bin/env python3

# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

# main() doesn't need to be defined for scripts that only contain functions,
# such as scripts under .../<distro-codename/windows-release>/

import sys
import platform
import subprocess
import PyInstaller.__main__ as PyInstaller

def getRequirements(requirementstxt):
    subprocess.check_call([
        sys.executable,
        '-m',
        'pip',
        'install',
        '-r',
        requirementstxt
    ])

def compile():
    PyInstaller.run([
        './pycypa/__main__.py',
        '--onefile',
        '--windowed',
        '-d imports',
        '-v',
    ])

def main():
#    getRequirements('./requirements.txt')

    if platform.system() == 'Linux':
        getRequirements( './pycypa/linux_requirements.txt' )

    elif platform.system() == 'Windows':
        return 0

    else:
        print("You are not on a supported platform. (Windows/Linux)")

if __name__ == '__main__':
    main()
