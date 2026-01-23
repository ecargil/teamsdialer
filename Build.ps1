# Find csc.exe (C# compiler)
$cscPath = Get-ChildItem -Path "C:\Windows\Microsoft.NET\Framework64" -Filter "csc.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName

if (-not $cscPath) {
    Write-Host "C# compiler not found. Installing .NET SDK..." -ForegroundColor Yellow
    winget install Microsoft.DotNet.SDK.8 --silent --accept-source-agreements --accept-package-agreements
    Write-Host "Please run this script again after .NET SDK installation completes." -ForegroundColor Green
    pause
    exit
}

Write-Host "Compiling TeamsDialer.exe..." -ForegroundColor Green

$iconParam = ""
if (Test-Path "phone.ico") {
    $iconParam = "/win32icon:`"phone.ico`""
}

& $cscPath /target:winexe $iconParam /r:System.Windows.Forms.dll /r:System.Drawing.dll /out:"TeamsDialer.exe" "Program.cs" "AssemblyInfo.cs"

if (Test-Path "TeamsDialer.exe") {
    Write-Host "`nCompilation successful!" -ForegroundColor Green
    Write-Host "TeamsDialer.exe is ready to use." -ForegroundColor Green
} else {
    Write-Host "`nCompilation failed!" -ForegroundColor Red
}

pause
