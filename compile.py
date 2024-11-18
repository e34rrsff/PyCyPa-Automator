#!/usr/bin/env python3

# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

# main() doesn't need to be defined for scripts that only contain functions,
# such as scripts under .../<distro-codename/windows-release>/

import sys
import platform
import subprocess
import PyInstaller.__main__

def getRequirements(requirementstxt):
    subprocess.check_call([
        sys.executable,
        '-m',
        'pip',
        'install',
        '-Ur',
        requirementstxt,
    ])

pyInstallerOptions = [
    './pycypa/__main__.py',
    '--onefile',
    '--windowed',
]

def main():

# Installing globally required packages/libraries
    getRequirements( './requirements.txt' )
    
    if platform.system() == 'Linux':
        # Get requirements for Linux with pip
        getRequirements( './pycypa/linux_requirements.txt' )
        
        import distro
        pyInstallerOptions.append( '--name=pycypa-' + distro.codename() )
        # PyInstaller needs help finding required imports
        pyInstallerOptions.append( '--hidden-import=linux' )

    elif platform.system() == 'Windows':
        getRequirements( './pycypa/windows_requirements.txt' )

        # Help for PyInstaller
        pyInstallerOptions.append( '--hidden-imports=windows' )

    else:
        print("You are not on a supported platform. (Windows/Linux)")
    
    # Prints out options gathered during the if statements above
    print("\nPyInstaller options: \n", pyInstallerOptions )
    PyInstaller.__main__.run( pyInstallerOptions )

if __name__ == '__main__':
    main()
