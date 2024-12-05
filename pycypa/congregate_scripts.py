# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

import os 
import re

from sys import exit as exit
from glob import glob
from subprocess import check_call
from itertools import chain
   
# I found this snippet online which sorts strings containing numbers, with
# regex
def num_sort(string):
        parts = re.split( '/', string )
        filename = parts[-1] if parts else ''
        return list( map( int, re.findall( r'\d+', filename )))[0]

def run(platformDir, releaseDir):
    
    platformDir = os.path.dirname(__file__) + '/' + platformDir + '/'
    releaseDir  = platformDir + releaseDir + '/'

    scriptList = (
            glob( platformDir + '[!__init__]*.py' ) +
            glob( releaseDir  + '[!__init__]*.py' )
    )
    scriptList.sort(key=num_sort)
    
    for scriptPath in scriptList:
        print("Using", scriptPath)

    for scriptPath in scriptList:
        try:
            check_call([ 'python', scriptPath ])
        except KeyboardInterrupt:
            print( 'User interrupted script, exiting.' )
            exit(1)
