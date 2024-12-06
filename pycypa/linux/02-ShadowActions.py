#!/usr/bin/env python
# Copyright 2024 PyCyPa Automator Developers.
# This file is subject to copyright restrictions defined by
# the COPYRIGHT file located at the top-level-directory of
# this codebase.

from subprocess import check_call
from tabulate import tabulate

def createList( userInput ):
    # x for x in <list> if x weirdly gets rid of empty strings.
    # .replace() turns spaces into empty strings and
    # .split() turns the single string into a list, sepearated by the commas in
    # the string
    return [ x for x in userInput.replace(' ', '').split(',') if x ]

# Get file formatting by file name
def getFileType(fileName):

    global filePath
    global tableData
    global importantFields
    global formatEntry

    if fileName == 'passwd':

        filePath = '/home/e34/projects/PyCyPa-Automator/tests/passwd'
        tableData = [ ['USER', 'UID', 'GID'] ]
        importantFields = [0, 2, 3]
        def formatEntry( entry ):
            return entry.split(':')

    elif fileName == 'group':
        pass

def tabulateFile(fileName):

    getFileType(fileName)

    with open( filePath, 'r' ) as file:
        fileData = []
        for entry in file:
        # Turn each /etc/passwd entry into a list of values
            fileData.append( formatEntry(entry) )
        # Sorting data numerically by the third index value (2) (the UID)
        sortedFile = sorted( fileData, key=lambda field: int(field[2]) )

    # Getting the data we want to print out in the table
    for entry in sortedFile:
        rowData = []
        # Grabbing value by index value, within each entry
        for fieldIndex in importantFields:
            rowData.append( entry[fieldIndex] )
        tableData.append( rowData )

    print( '\n' + tabulate(tableData, headers='firstrow') )

def manage( action ):

        # Delete users
        if action == 'deleteUsers':
            while True:
                try:
                    usersToRemove = createList( input(f'''
{blue}Enter a list of users that should be {red}REMOVED{nocolor}
Remove users: '''))
                    for user in usersToRemove:
                        check_call([ 'userdel', user ])
                except Exception:
                    continue
                break
        # Define non-admin users
        if action == 'makeNonAdmin':
            while True:
                try:
                    nonAdminList = createList( input(f'''
{blue}Enter the list of authorized {yellow}non-admin users{nocolor}
Regular users: '''))
                    for user in values:
                        check_call([ 'gpasswd', '--delete', user, 'sudo' ])
                        check_call([ 'gpasswd', '--delete', user, 'admin' ])

        # Define admin users
        if action == 'makeAdmin':
            while True:
                try:
                    adminList = createList( input(f'''
{blue}Enter a list of users that should be {red}admins{nocolor}
Sudoers: '''))
                    for user in values:
                        check_call([ 'usermod', '-aG', 'sudo', user ])
                        check_call([ 'usermod', '-aG', 'admin', user ])
                except:
                    continue
                break

# Terminal colors
red      = '\033[31m'
yellow   = '\033[33m'
green    = '\033[32m'
blue     = '\033[34m'
nocolor  = '\033[0m'

tabulateFile( 'passwd' )
print( f'''{green}
* Lists are strings, separated by commas
* Leave unnecessary actions empty
{nocolor}''',end='')

manage( 'deleteUsers' )

manage( 'makeNonAdmin', nonAdminList )

