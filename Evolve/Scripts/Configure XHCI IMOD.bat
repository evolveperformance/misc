@echo off
Color B
title IMOD Auto-Launch Manager
SETLOCAL EnableDelayedExpansion

:main
cls
echo.
echo.    Press [1] to Disable IMOD at boot
echo.    Press [2] to REMOVE auto-launch
echo.    Press [3] to EXIT
echo.

choice /c 123 /n /m "Choose Option: "

if errorlevel 3 goto :exit
if errorlevel 2 goto :remove
if errorlevel 1 goto :add

:add
cls
echo Adding IMOD.exe to auto-launch on boot...
schtasks /create /tn "IMOD" /tr "C:\Windows\Misc\IMOD\IMOD.exe" /sc onlogon /rl highest /f >nul 2>&1
if %errorlevel%==0 (
    echo Successfully added IMOD auto-launch.
) else (
    echo Failed to add auto-launch.
)
exit

:remove
cls
echo Removing IMOD.exe auto-launch...
schtasks /delete /tn "IMOD" /f >nul 2>&1
if %errorlevel%==0 (
    echo Successfully removed IMOD auto-launch.
) else (
    echo Task not found or removal failed.
)
exit

:exit
exit
