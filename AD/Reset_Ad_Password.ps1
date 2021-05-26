# Microsoft PowerShell script to reset a user's password
# Author: Guy Thomas
Function Reset-UserPassword{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$user,
        
        [Parameter(Mandatory=$true, Position=1)]
        [string]$newPass
    )

    if(($newPass -cmatch '[a-z]') -and ($newPass -cmatch '[A-Z]') -and ($newPass -match '\d') -and ($newPass.length -match '^([7-9]|[1][0-9]|[2][0-5])$') -and ($newPass -match '!|@|#|%|^|&|$|_')) 
{ 
    Write-Host "`nPassword is valid!`n"
} 
else
{ 
    Write-Host "`nPassword is invalid!`n"
}

try {

Set-ADAccountPassword -whatif -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$newPass" -Force)
Write-Output "Password for user: $user was reset to $newPass"
}
catch {
Write-Warning $Error[0]
}




}
