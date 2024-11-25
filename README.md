PyCyPa Automator
================
##### Python scripts for our team to use during the CyberPatriot competition (2024-2025)

### Structure

###### Note: the naming scheme derives from the python library _'distro'_ and Python's built-in library _'platform'_
| .../pycypa-automator/ | Description |
| :- | :----- |
| .../linux/			| Similarly, if you need to write a distro-specific solution, put the script under linux/\<distro-codename\>. (e.g. jammy, vanessa, bookworm) |
| .../windows/		| If there is a solution that is strictly release-specific, put it under windows/\<windows-release\>. (e.g. 10, 11, 2019Server) |
| .../\[windows/linux]/configs.csv | Specific configuration values should be stored here for easy management and access.
| .../references/ 	| Add any useful notes or files used for reference here. |
| .../tests/			| Use this directory for testing your solutions with Python.

### Compilation

Running `compile.py` should pack everything you need intoa single binary for the target system.

Specify the target system with `--target=`

The produced binary will be under `dist/`.

### Helpful Python notes

> IMPORTANT: You need a Python virtual environment to install PyInstaller.
> You can use the setup-pyvenv.sh script to do this for you.

> A \_\_main__.py and \_\_init__.py allows the directory the file is in to be imported as if it were a Python script
