from subprocess import check_call
from os import environ
from time import sleep

userHome = environ[ 'HOME' ]

def openForensicQuestion( num ):

    for i in range(3, 0, -1):
        print( f'\rOpening forensic question {num} in {i}...',\
                end='',\
                flush=True
        )
        sleep(1)

    check_call([ 'editor',
                userHome
                + '/Desktop/Forensics Question '
                + str( num ) + '.txt'
    ])

for i in range(1, 3, 1):
    openForensicQuestion(i)
    print( '\n' )

input( 'Forensic questions completed. Press ENTER to continue...' )
