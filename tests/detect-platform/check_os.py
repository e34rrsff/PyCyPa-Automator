import platform

if platform.system() == "Linux":
    from platforms import debian
    debian.main()

