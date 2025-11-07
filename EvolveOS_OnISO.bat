@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=G:\GitHub Projects\EvolveOS_OnISO.exe
REM BFCPEICON=C:\Program Files (x86)\Advanced BAT to EXE Converter v4.62\ab2econv462\icons\icon13.ico
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=0
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Evolve Performance Optimization
REM BFCPEVERDESC=Evolve Performance Post Install for ISO
REM BFCPEVERCOMPANY=Evolve Performance
REM BFCPEVERCOPYRIGHT=Copyright � 2025 Evolve Performance
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=30
REM BFCPEWINDOWWIDTH=120
REM BFCPEWTITLE=Evolve Performance Post Install
REM BFCPEOPTIONEND
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
curl.exe -L "https://github.com/evolveperformance/misc/raw/main/EvolveOS_Locally.bat?v=%RANDOM%" -o "%SETUP_BAT%"

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

:: Simple cleanup - just delete the downloaded script
echo.
echo Cleaning up...
del "%SETUP_BAT%" >nul 2>&1

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
