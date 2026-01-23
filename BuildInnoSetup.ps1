# Build TeamsDialer with Inno Setup

Write-Host "Building TeamsDialer Installer with Inno Setup..." -ForegroundColor Green

# Check if TeamsDialer.exe exists
if (-not (Test-Path "TeamsDialer.exe")) {
    Write-Host "TeamsDialer.exe not found. Building..." -ForegroundColor Yellow
    & .\Build.ps1
}

if (-not (Test-Path "TeamsDialer.exe")) {
    Write-Host "ERROR: TeamsDialer.exe not found!" -ForegroundColor Red
    pause
    exit
}

# Find Inno Setup compiler
$isccPaths = @(
    "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe",
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
    "C:\Program Files\Inno Setup 6\ISCC.exe",
    "C:\Program Files (x86)\Inno Setup 5\ISCC.exe",
    "C:\Program Files\Inno Setup 5\ISCC.exe"
)

$isccPath = $null
foreach ($path in $isccPaths) {
    if (Test-Path $path) {
        $isccPath = $path
        break
    }
}

if (-not $isccPath) {
    Write-Host "ERROR: Inno Setup not found!" -ForegroundColor Red
    Write-Host "Please install Inno Setup from: https://jrsoftware.org/isdl.php" -ForegroundColor Yellow
    pause
    exit
}

# Compile installer
Write-Host "Compiling installer..." -ForegroundColor Green
& $isccPath "TeamsDialer.iss"

if (Test-Path "TeamsDialerSetup.exe") {
    Write-Host "`nInstaller created successfully!" -ForegroundColor Green
    Write-Host "TeamsDialerSetup.exe is ready to distribute." -ForegroundColor Green
} else {
    Write-Host "`nInstaller build failed!" -ForegroundColor Red
}

pause
