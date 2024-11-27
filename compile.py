#!/usr/bin/env python3

# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

# main() doesn't need to be defined for scripts that only contain functions,
# such as scripts under .../<distro-codename/windows-release>/

from os import path, sep
from sys import exit, executable
from platform import system
from subprocess import check_call
from argparse import ArgumentParser
import PyInstaller.__main__

# argparse is a library that add CLI argument-passing functionality
parser = ArgumentParser( description='PyCyPa' )
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
        else:
            continue

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
        else:
            continue

    print( 'Not a supported/recognized target' )
    exit()

# Just executes a pip install with a .txt file containing library names
def getRequirements(requirementstxt):
    check_call([
        executable,
        '-m',
        'pip',
        'install',
        '-qUr',
        requirementstxt,
    ])

validateSystem( system() )
validateTarget( parser.parse_args().target )

# The path of this "compile.py" file
compilePyPath = path.dirname(__file__)

# Options that would be used with the CLI command pyinstaller
pyInstallerOptions = [
    compilePyPath + sep + 'pycypa' + sep + '__main__.py',
    '--onefile',
    '--windowed',
    '--log-level=ERROR',
    '--name=pycypa-' + target,
    '--hidden-import=' + system,
    '--hidden-import='
        + system + '.'
        + target,
    '--add-data='
        + compilePyPath + sep
        + 'pycypa' + sep
        + system + sep
        + target + ':'
        + system + sep
        + target,
]

# Prints out the options gathered during above "appends"
print("\nPyInstaller options: \n", pyInstallerOptions )

# Installing globally required packages/libraries
getRequirements( compilePyPath + sep + 'requirements.txt' )

# Platform-specific dependencies
getRequirements( compilePyPath + sep + 'pycypa'
                + sep + system + '_requirements.txt' )

PyInstaller.__main__.run( pyInstallerOptions )
