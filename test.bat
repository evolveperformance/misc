@echo off

"C:\Windows\Misc\StartAllBackSetup.exe" /silent /allusers >nul 2>&1
powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File "C:\Windows\Misc\PatchStartAllBack.ps1" >nul 2>&1
reg import "C:\Windows\Misc\StartAllBack.reg" >nul 2>&1