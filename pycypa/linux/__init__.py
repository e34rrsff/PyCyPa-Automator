# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

import distro
import congregate_scripts as congregateScripts

class system:
    platformDir = 'linux'
    codenameDir = distro.codename()

def run():
    congregateScripts.run( system.platformDir, system.codenameDir )
