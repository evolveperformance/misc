@echo off
title MSI Afterburner - Auto Profile 1
color 0A

:: Launch MSI Afterburner with Profile 1 silently
start "" "C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe" /Profile1

:: Wait 7 seconds (gives time to load + apply the profile)
timeout /t 7 /nobreak >nul

:: Kill Afterburner if it’s still running
taskkill /IM MSIAfterburner.exe /F >nul 2>&1

echo ✅  MSI Afterburner Profile 1 applied successfully.
exit /b
