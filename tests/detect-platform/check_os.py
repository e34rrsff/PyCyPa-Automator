import platform

if platform.system() == "Linux":
    from platforms import linux
    linux.main()

