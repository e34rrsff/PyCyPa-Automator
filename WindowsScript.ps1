#Enable Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

#Enable UAC. Set to 5 for default, 1 for more secure
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 5

#Disable RDP Set value to 0 if RDP is required, 1 if you want it disabled
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 1
Disable-NetFirewallRule -DisplayGroup "Remote Desktop"

#MAKE AS SEPERATE SCRIPT This updates Windows
Install-module -Name PSWindowsUpdate -Force
get-package -Name PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install -Autoreboot

#change the .avi depending what you are searching for (.mp3 .mp4 .avi .ogg .wav)
Get-Childitem -Path C:\ -Include *.avi -File -Recurse -ErrorAction SilentlyContinue > media.txt

#deletes the media files you found. change based on the directory it will be in.
del 'c:\users\ashepard\music\pure Piano\ Improv\'

#This shows all users on the system who are active or deactive. Moves all them to a text file to compare with read me easier
get-localuser > allusers.txt

#Shows all admins on the system. Moves to a text file to compare with read me easier.
get-localgroupmember -Group "administrators" > admin.txt

#shows all applictions on the system and inputs it into a text file.
get-wmiobject -class Win32_Product > apps.txt

#Enables Window Defender MAY NOT WORK so
c:\"Program Files"\"Windows Defender"\MpCmdRun.exe -wdenable


Auditpol /set /category:"Account Logon" /success:enable /failure:enable
Auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
Auditpol /set /category:"Account Management" /success:enable /failure:enable
Auditpol /set /subcategory:"Directory Service Access" /success:enable /failure:enable
Auditpol /set /subcategory:"Object Access" /success:enable /failure:enable
Auditpol /set /category:"Policy Change" /success:enable /failure:enable
Auditpol /set /category:"Privilege Use" /success:enable /failure:enable
Auditpol /set /subcategory:"Process Creation" /success:enable /failure:enable
