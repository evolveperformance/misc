@echo off
title Evolve OS Setup

:checkInternet
echo Checking internet connection...
ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo No internet connection. Retrying in 5 seconds...
    timeout /t 5 /nobreak >nul
    goto checkInternet
)

echo Internet connection detected.
echo Downloading latest Evolve configuration...

set "Evolve_BAT=%TEMP%\EvolveOS_Online.bat"
curl.exe -L "https://github.com/evolveperformance/misc/blob/main/EvolveOS.bat" -o "%Evolve_BAT%"

if not exist "%Evolve_BAT%" (
    echo [!] Download failed. Exiting.
    exit /b
)

echo Running Evolve setup...
call "%Evolve_BAT%"

echo.
echo Cleaning up temporary files...
del "%Evolve_BAT%" >nul 2>&1

echo.
echo Restarting system to apply changes...
shutdown /r /t 5
exit
