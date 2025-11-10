@echo off

"C:\Windows\Misc\StartAllBackSetup.exe" /silent /allusers >nul 2>&1

REM Create Evolve shortcut
powershell -Command "$WS = New-Object -ComObject WScript.Shell; $SC = $WS.CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\Evolve.lnk'); $SC.TargetPath = 'C:\Windows\Evolve'; $SC.IconLocation = 'imageres.dll,3'; $SC.Save()"

powershell -ExecutionPolicy Bypass -File "C:\Windows\Misc\PatchStartAllBack.ps1"

reg import "C:\Windows\Misc\StartAllBack.reg" >nul 2>&1
