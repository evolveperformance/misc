@echo Create Scheduled Task for Weekly TEMP Cleanup
:: Create batch file in Misc folder
(
echo @echo off
echo del /q /f /s "C:\Windows\Temp\*" ^>nul 2^>^&1
echo for /d %%%%d in ("C:\Windows\Temp\*"^) do rd /s /q "%%%%d" ^>nul 2^>^&1
echo for /d %%%%u in ("C:\Users\*"^) do ^(
echo     if exist "%%%%u\AppData\Local\Temp" ^(
echo         del /q /f /s "%%%%u\AppData\Local\Temp\*" ^>nul 2^>^&1
echo         for /d %%%%d in ("%%%%u\AppData\Local\Temp\*"^) do rd /s /q "%%%%d" ^>nul 2^>^&1
echo     ^)
echo ^)
) > "C:\Windows\Misc\CleanTemp.bat"

:: Create scheduled task to run every Sunday at 3:00 AM
schtasks /create /tn "Evolve\Weekly TEMP Cleanup" /tr "C:\Windows\Misc\CleanTemp.bat" /sc weekly /d SUN /st 03:00 /ru SYSTEM /rl HIGHEST /f >nul 2>&1