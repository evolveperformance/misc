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
call "%SETUP_BAT%"

echo.
echo Restarting system to apply changes...
shutdown /r /t 5
