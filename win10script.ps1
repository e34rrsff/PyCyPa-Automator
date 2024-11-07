# firewall grahhhhh
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# UAC, 5 for normal, -1 for secure
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 5

# disable rdp, uncomment depending on scenario
# Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 1
# Disable-NetFireWallRule -DisplayGroup "Remote Desktop"

# enable rdp, uncomment depending on scenario
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0
Enable-NetFireWallRule -DisplayGroup "Remote Desktop"

# updates
Install-Module -Name PSWindowsUpdate -Force
Get-Package -Name PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install

Function Set-LocalPasswordPolicy {
    <#
        .DESCRIPTION
        Sets the local password policy

        .SYNOPSIS
        Sets the local password policy

        .PARAMETER PasswordComplexity
        Specifies whether passwords must meet complexity requirements.

        .PARAMETER MinimumPasswordLength
        Specifies the minimum number of characters that passwords must contain.

        .PARAMETER MinimumPasswordAge
        Specifies the minimum number of days that passwords must be used before they can be changed.

        .PARAMETER MaximumPasswordAge
        Specifies the maximum number of days that passwords can be used before they must be changed.

        .PARAMETER PasswordHistorySize
        Specifies the number of new passwords that have to be associated with a user account before an old password can be reused.

        .PARAMETER LockoutBadCount
        Specifies the number of failed logon attempts that causes a user account to be locked out.

        .PARAMETER ResetLockoutCount
        Specifies the number of minutes that must elapse after a failed logon attempt before the failed logon attempt counter is reset to 0 bad logon attempts.

        .PARAMETER LockoutDuration
        Specifies the number of minutes a user account is locked out after the number of failed logon attempts specified by the LockoutBadCount parameter is exceeded.

        .EXAMPLE
        Set-LocalPasswordPolicy -PasswordComplexity $true -MinimumPasswordLength 8 -MinimumPasswordAge 1 -MaximumPasswordAge 90 -PasswordHistorySize 24 -LockoutBadCount 5 -ResetLockoutCount 15 -LockoutDuration 15

        .NOTES
        Author: Gabe Delaney
        Date: 05/23/2023
        Version: 1.0
        Name: Set-LocalPasswordPolicy

        Version History:
        1.0 - Initial release - 05/23/2023 - Gabe Delaney

    #>
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true)]
        [boolean]$PasswordComplexity,
        [Parameter(Mandatory=$false)]
        [int]$MinimumPasswordLength,
        [Parameter(Mandatory=$false)]
        [int]$MinimumPasswordAge,
        [Parameter(Mandatory=$false)]
        [int]$MaximumPasswordAge,
        [Parameter(Mandatory=$false)]
        [int]$PasswordHistorySize,
        [Parameter(Mandatory=$false)]
        [int]$LockoutBadCount,
        [Parameter(Mandatory=$false)]
        [int]$ResetLockoutCount,
        [Parameter(Mandatory=$false)]
        [int]$LockoutDuration

    )
    Begin {
        # Check if the current user is elevated as admin
        $principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
        $is_admin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
        If (!$is_admin) {
            Write-Error "You must run this function as an administrator."
            Break

        }

        # Export the current local security policy to a file
        $outfile = "$Env:TEMP\secpol.cfg"
        secedit /export /cfg $outfile | Out-Null

        # Read the current local security policy file
        $sec_pol_cfg = Get-Content $outfile
    } Process {
        # If parameters are specified, update the local security policy file
        If ($PSCmdlet.ShouldProcess("$Env:COMPUTERNAME")) {
            Foreach ($key in $PSBoundParameters.Keys) {
                If (@([System.Management.Automation.Cmdlet]::CommonParameters,"Confirm") -contains $key) {
                    Continue

                }
                [int]$value = $PSBoundParameters[$key]
                $sec_pol_cfg = $sec_pol_cfg -replace ("$key = \d+", "$key = $value")

            }
            # Write the updated local security policy file
            $sec_pol_cfg | Out-File $outfile -Force
            secedit /configure /db c:\windows\security\local.sdb /cfg $outfile /areas SECURITYPOLICY | Out-Null

            # Remove the local security policy file
            Remove-Item $outfile -Force | Out-Null

        }
    } End {
        Return

    }
}

Set-Localpasswordpolicy -Minimumpasswordlength 10 -MinimumPasswordAge 1 -MaximumPasswordAge 90 -PasswordHistorySize 5 -LockoutBadCount 5 -ResetLockoutCount 30 -LockoutDuration 30 -PasswordComplexity $true

Get-LocalUser | Select-Object -Property Name > users.txt
compare-object (get-content users.txt) (get-content goodusers.txt)
Get-ChildItem -Path c:\users\ -include *.pdf -file -Recurse -ErrorAction SilentlyContinue > media.txt
