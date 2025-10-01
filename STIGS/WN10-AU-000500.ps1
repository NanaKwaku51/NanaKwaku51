 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Kwaku Boateng
    LinkedIn        : www.linkedin.com/in/nana-kwaku-boateng
    GitHub          : https://github.com/NanaKwaku51
    Date Created    : 2024-09-09
    Last Modified   : 2025-09-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE# Remediation for STIG WN10-AU-000500
# Ensure Application Event Log MaxSize is set to at least 32768 KB (32 MB)

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$Name    = "MaxSize"
$Value   = 32768  # decimal = 0x00008000

# Create the registry path if it doesn’t exist
if (-not (Test-Path $RegPath)) {
    Write-Host "Registry path not found. Creating: $RegPath"
    New-Item -Path $RegPath -Force | Out-Null
}

# Create or update the registry value
if (-not (Get-ItemProperty -Path $RegPath -Name $Name -ErrorAction SilentlyContinue)) {
    Write-Host "Registry value not found. Creating: $Name = $Value"
    New-ItemProperty -Path $RegPath -Name $Name -Value $Value -PropertyType DWord -Force | Out-Null
} else {
    Write-Host "Registry value exists. Setting $Name = $Value"
    Set-ItemProperty -Path $RegPath -Name $Name -Value $Value
}

# Verify setting
$current = (Get-ItemProperty -Path $RegPath -Name $Name).$Name
Write-Host "✅ Application Event Log MaxSize is set to $current KB" 
