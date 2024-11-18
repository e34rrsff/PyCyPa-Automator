#!/usr/bin/env python3

# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

# main() doesn't need to be defined for scripts that only contain functions,
# such as scripts under .../<distro-codename/windows-release>/

import sys
import platform
import subprocess
import argparse
import PyInstaller.__main__

# argparse is a library that add CLI argument-passing functionality
parser = argparse.ArgumentParser( description='PyCyPa' )
parser.add_argument(
    '--target',
    type=str,
    help='Supply the target machine release/codename',
    required=True
)

def validateSystem(systemName):
    availableSystems = [
            'Linux',
            'Windows',
    ]

    for name in availableSystems:
        if systemName == name:
            global system
            system = systemName.lower()
            return

def validateTarget(targetName):
    # For now, the available targets will have to be manually added
    availableTargets = [
        'jammy',
        'vanessa',
        '10',
        '2019Server',
    ]

    # Iterates through the available target names to see it the one
    # supplied to the script is available
    for name in availableTargets:
        if targetName == name:
            global target
            target = targetName
            return

    print( 'Not a supported/recognized target' )
    sys.exit()

# Just executes a pip install with a .txt file containing library names
def getRequirements(requirementstxt):
    subprocess.check_call([
        sys.executable,
        '-m',
        'pip',
        'install',
        '-Ur',
        requirementstxt,
    ])

# Options that would be used with the CLI command pyinstaller
pyInstallerOptions = [
    './pycypa/__main__.py',
    '--onefile',
    '--windowed',
]

def main():

    validateSystem( platform.system() )
    validateTarget( parser.parse_args().target )

    pyInstallerOptions.append( '--name=pycypa-' + target )
    pyInstallerOptions.append( '--hidden-import=' + system )
    pyInstallerOptions.append(
        '--hidden-import=' + system + '.' + target )

    # Installing globally required packages/libraries
    getRequirements( './requirements.txt' )
    getRequirements( './pycypa/' + system + '_requirements.txt' )

    # Prints out options gathered during the if statements above
    print("\nPyInstaller options: \n", pyInstallerOptions )
    PyInstaller.__main__.run( pyInstallerOptions )

if __name__ == '__main__':
    main()
