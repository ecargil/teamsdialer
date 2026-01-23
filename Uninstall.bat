@echo off
echo ========================================
echo TeamsDialer Uninstaller
echo ========================================
echo.
echo This will remove TeamsDialer registration from your system.
echo.
pause

echo Removing registry entries...

reg delete "HKCU\Software\Classes\tel" /f 2>nul
reg delete "HKCU\Software\TeamsDialer" /f 2>nul
reg delete "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\tel\UserChoice" /f 2>nul

echo.
echo TeamsDialer has been uninstalled.
echo You can now delete the TeamsDialer.exe file manually.
echo.
pause
