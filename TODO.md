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
        - [ ] `login.defs`
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

        - [ ] `sudoers(.d)`
            * `env_reset` should be set
            * `setenv` should NOT be set
            * There should be no "...`mail`..." options set
            * `secure_path` should only be set to protected directories
            * Set `syslog` to enable logging
            * Set `timestamp_timeout` to `0` disable sudo timeouts
            * There shouldn't be any `NOPASSWD` entries
            * Only `sudo` & `admin` group should be able to run "`ALL`"
            commands as root
            * **ALSO** check files under `sudoers.d`

- [ ] Checking crons
- [ ] Checking ssh config
- [ ] Checking firewall rules, turning on firewall
- [ ] Setting password reqs (pam.d)
- [ ] Checking packages
- [ ] Running updates (not 100 percent needed)
- [ ] [sample text]

---
