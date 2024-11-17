CyberPatriot Scripts
====================
##### Scripts for our team to use during the competition (2024-2025)

### Structure
###### Note: the naming scheme derives from the python library _'distro'_ and Python's built-in library _'platform'_
| .../pycypa-automator/ | Description |
| :- | :----- |
| .../linux/			| Similarly, if you need to write a distro-specific solution, put the script under linux/\<distro-codename\>.<br>(e.g. jammy, vanessa, bookworm) |
| .../windows/		| If there is a solution that is strictly release-specific, put it under windows/\<windows-release\>. (e.g. 10, 11, 2019Server) |
| .../\[windows/linux]/configs.csv | Specific configuration values should be stored here for easy management and access.
| .../references/ 	| Add any useful notes or files used for reference here. |
| .../tests/			| Use this directory for testing your solutions with Python.

### Helpful Python notes
> An \_\_init\_\_.py file makes sure that Python scripts within the same directory are available to scripts from above that directory. It can simply be left empty.
