Todo
====

## General
- [ ] ~~Make PyInstaller hooks to only build for the current host's OS~~ (was a bad idea)

- [X] Support to specify target system build

- [ ] (in progress) Determine the release version/distro of OS to compile with PyInstaller

- [ ] Aggregate scripts under (windows/linux)/<release>

- [ ] (Maybe) Interactive prompt for forensic questions and other **.txt** files

---

## Windows
- [ ] Check for backdoors
- [ ] Check users and groups
- [ ] Run an `sfc` check
- [ ] Check for media files
- [ ] [sample text]

---

## Linux
- [ ] Checking for backdoors
- [ ] Fix users and groups
- [ ] Checking the filesystem for SUS stuff
	- [ ] `/etc/`
        - [ ] Read up on `login.defs`
            - "man" page:
            https://man7.org/linux/man-pages/man5/login.defs.5.html
        - [ ] `sudoers`(`.d`)
            * There shouldn't be any NOPASSWD entries
            * Only sudo and admin groups should have root command access
            * **ALSO** check files under `sudoers.d`
- [ ] Checking crons
- [ ] Checking ssh config
- [ ] Checking firewall rules, turning on firewall
- [ ] Setting password reqs (pam.d)
- [ ] Checking packages
- [ ] Running updates (not 100 percent needed)
- [ ] [sample text]

---
