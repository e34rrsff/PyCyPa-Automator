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
- [X] Write answers to forensic questions
- [ ] Fix users and groups
- [ ] Checking for backdoors
- [ ] Checking the filesystem for SUS stuff
	- [ ] `/etc`

        - [ ] `/adduser.conf`

            Pretty much everything here should be commented out so that the
            defaults are used. If ther are any uncommented lines, it may have
            been tampered with.

        - [ ] `/aliases`

            * `postmaster` should be set to `root`

            That should be all that's in the file.

        - [ ] `/anacrontab`

            * `SHELL` should be set to `/bin/sh`
            * `HOME` : `/root`
            * `LOGNAME` : `root`

        - [ ] Display Manager (lightdm/gdm)

            The Linux image usually uses one of these two display managers;
            detect and configure the correct one.

            - [ ] `/gdm3/greeter.dconf-defaults`
                * `disable-user-list` should be set to `true`
                * `disable-restart-buttons` should be set to true

        - [ ] `/login.defs`
            * `ENCRYPT_METHOD` = "SHA512"
            * `LOG_OK_LOGINS` should be set to  `yes`
            * `LOG_UNKFAIL_ENAB` should be set to `yes`
            * `LOGIN_RETRIES` should be set to `5`
            * `LOGIN_TIMEOUT` should be set to `60`
            * `PASS_MAX_DAYS` should be set to `90`
            * `PASS_MIN_DAYS` should be set to `1`
            * `PASS_WARN_AGE` should be set to `7`

              	> Label is misleading; this will warn the user 7 days before their password expires.
          	
                > **IMPORTANT**: Current users **will not** get their password expiry settings updated after editing `login.defs`. Updates to `/etc/shadow` are required.
      		
            * `SYSLOG_SG_ENAB` should be set to `yes`
            * `SYSLOG_SU_ENAB` should be set to `yes`
            * `USERGROUPS_ENAB` should be set to `yes`
            * Set permissions for the file to `0400`

        - [ ] `/sudoers(.d)`
            * `env_reset` should be set
            * `setenv` should NOT be set
            * "...`mail`..." options shouldn't be set
            * `secure_path` should be set to *protected* directories
            * `syslog` set to enable logging
            * `timestamp_timeout` set to `0` to disable sudo timeouts
            * `NOPASSWD` should not exist in any permission entries
            * `sudo` & `admin` groups should be able to run "`ALL`"
            commands as root
            * `sudoers.d` may contain other files worth looking at

- [ ] Checking crons
- [ ] Checking ssh config
- [ ] Checking firewall rules, turning on firewall
- [ ] Setting password reqs (pam.d)
- [ ] Checking packages
- [ ] Running updates (not 100 percent needed)
- [ ] [sample text]
