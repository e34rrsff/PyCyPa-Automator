# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

from platform import release
import congregate_scripts as congregateScripts

class system:
    platformDir = 'windows'
    releaseDir = ( release() )

def run():
    congregateScripts.run( system.platformDir, system.releaseDir )
