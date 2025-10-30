@echo off
title OBS Auto-Start Setup
color 0A

echo ==============================================
echo        OBS AUTO-START + REPLAY BUFFER
echo ==============================================
echo.

set "OBS_EXE=C:\Program Files\obs-studio\bin\64bit\obs64.exe"
set "SHORTCUT=%TEMP%\OBS AutoStart.lnk"
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "ARGS=--startreplaybuffer --minimize-to-tray --disable-update --disable-shutdown-check"

:: Verify OBS exists
if not exist "%OBS_EXE%" (
    echo [ERROR] OBS not found at "%OBS_EXE%"
    echo Please install OBS via the Ultron App Installer first.
    pause
    exit /b
)

echo Creating shortcut...

:: Create shortcut with PowerShell (single line, no ^ issues)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT%'); $Shortcut.TargetPath = '%OBS_EXE%'; $Shortcut.Arguments = '%ARGS%'; $Shortcut.WorkingDirectory = 'C:\Program Files\obs-studio\bin\64bit'; $Shortcut.WindowStyle = 7; $Shortcut.IconLocation = '%OBS_EXE%,0'; $Shortcut.Save();"

:: Move shortcut to Startup folder
echo Moving shortcut to Startup folder...
move /Y "%SHORTCUT%" "%STARTUP%\OBS AutoStart.lnk" >nul 2>&1

if errorlevel 1 (
    echo [WARNING] Could not move shortcut automatically. Please check permissions.
) else (
    echo ✅ Shortcut added to Startup.
)

:: Launch OBS once to verify setup
echo Launching OBS once to verify setup...
start "" "%OBS_EXE%" %ARGS%

echo.
echo ✅ Done! OBS will now start automatically when Windows boots,
echo    minimized to tray with Replay Buffer active.
pause
exit /b
