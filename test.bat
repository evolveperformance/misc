@echo off

@echo Install Icon to Path
curl.exe -L "https://github.com/evolveperformance/misc/raw/main/blank.ico?v=%RANDOM%" -o "C:\Windows\EvolveSetup\Visuals\blank.ico"

copy "C:\Windows\EvolveSetup\Visuals\blank.ico" "C:\Windows" /Y >nul 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "C:\Windows\blank.ico" /f >nul 2>&1