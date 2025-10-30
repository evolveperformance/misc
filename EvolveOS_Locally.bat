@echo off
title Ultron OS Setup

:checkInternet
echo Checking internet connection...
ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo No internet connection. Retrying in 5 seconds...
    timeout /t 5 /nobreak >nul
    goto checkInternet
)

echo Internet connection detected.
echo Downloading latest Ultron configuration...

set "ULTRON_BAT=%TEMP%\UltronOS_Online.bat"
curl.exe -L "https://gitlab.cs.hs-rm.de/lstru001/misc/-/raw/main/UltronOS.bat" -o "%ULTRON_BAT%"

if not exist "%ULTRON_BAT%" (
    echo [!] Download failed. Exiting.
    exit /b
)

echo Running Ultron setup...
call "%ULTRON_BAT%"

echo.
echo Cleaning up temporary files...
del "%ULTRON_BAT%" >nul 2>&1

echo.
echo Restarting system to apply changes...
shutdown /r /t 5
exit
