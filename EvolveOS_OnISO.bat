@echo off
title Evolve OS Setup - Local Launcher

:checkInternet
echo Checking internet connection...
ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo [!] No internet connection detected.
    echo [!] Internet is required to download the setup files.
    echo Retrying in 5 seconds...
    timeout /t 5 /nobreak >nul
    goto checkInternet
)

echo Internet connection detected.
echo.
echo Downloading Evolve OS setup script...
set "SETUP_BAT=%~dp0EvolveOS_Locally.bat"
curl.exe -L "https://github.com/evolveperformance/misc/raw/main/EvolveOS_Locally.bat" -o "%SETUP_BAT%"

if not exist "%SETUP_BAT%" (
    echo [!] Download failed. Please check your internet connection.
    echo [!] Press any key to retry...
    pause >nul
    goto checkInternet
)

echo Download completed successfully.
echo.
echo Running Evolve OS setup...
echo.

call "%SETUP_BAT%"
set SETUP_ERROR=%ERRORLEVEL%

if %SETUP_ERROR% NEQ 0 (
    echo.
    echo [!] Setup returned error code: %SETUP_ERROR%
    echo [!] Press any key to exit without restarting...
    pause >nul
    exit /b %SETUP_ERROR%
)

echo.
echo ============================================
echo   EvolveOS Setup Complete!
echo ============================================
echo.
echo System will restart in 10 seconds...
echo Press any key to restart now, or Ctrl+C to cancel.
echo.

timeout /t 10
shutdown /r /t 0 /c "EvolveOS configuration complete. Restarting system..."
