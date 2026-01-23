# System-wide installation script (requires Administrator)
# This is OPTIONAL - TeamsDialer.exe is self-installing for current user

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "TeamsDialer System-Wide Installer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "NOTE: This is optional. TeamsDialer.exe is self-installing." -ForegroundColor Yellow
Write-Host "This script installs TeamsDialer system-wide for all users." -ForegroundColor Yellow
Write-Host ""

# Check for admin rights
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Restarting as Administrator..." -ForegroundColor Yellow
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

if (-not (Test-Path "TeamsDialer.exe")) {
    Write-Host "ERROR: TeamsDialer.exe not found. Run Build.ps1 first." -ForegroundColor Red
    pause
    exit
}

# Install to Program Files
$installPath = "C:\Program Files\TeamsDialer"
Write-Host "Installing to $installPath..." -ForegroundColor Green
New-Item -Path $installPath -ItemType Directory -Force | Out-Null
Copy-Item "TeamsDialer.exe" -Destination $installPath -Force

Write-Host "Registering tel: protocol handler..." -ForegroundColor Green

$exePath = "$installPath\TeamsDialer.exe"

# Register in HKEY_LOCAL_MACHINE (system-wide)
reg add "HKLM\SOFTWARE\Classes\tel" /ve /d "URL:tel Protocol" /f | Out-Null
reg add "HKLM\SOFTWARE\Classes\tel" /v "URL Protocol" /d "" /f | Out-Null
reg add "HKLM\SOFTWARE\Classes\tel\shell\open\command" /ve /d "`"$exePath`" `"%1`"" /f | Out-Null

reg add "HKLM\SOFTWARE\TeamsDialer\Capabilities" /v "ApplicationName" /d "Teams Dialer" /f | Out-Null
reg add "HKLM\SOFTWARE\TeamsDialer\Capabilities" /v "ApplicationDescription" /d "Dial with Microsoft Teams" /f | Out-Null
reg add "HKLM\SOFTWARE\TeamsDialer\Capabilities\URLAssociations" /v "tel" /d "tel" /f | Out-Null
reg add "HKLM\SOFTWARE\RegisteredApplications" /v "TeamsDialer" /d "SOFTWARE\TeamsDialer\Capabilities" /f | Out-Null

Write-Host ""
Write-Host "TeamsDialer installed successfully!" -ForegroundColor Green
Write-Host "Location: $installPath\TeamsDialer.exe" -ForegroundColor Green
Write-Host ""
pause
