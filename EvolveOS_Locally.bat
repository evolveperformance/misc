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

echo Downloading Misc folder...
set "Misc_ZIP=%TEMP%\WindowsMisc.zip"
curl.exe -L "https://github.com/evolveperformance/WindowsMisc/archive/refs/heads/main.zip" -o "%Misc_ZIP%"

if not exist "%Misc_ZIP%" (
    echo [!] WindowsMisc.zip download failed. Exiting.
    exit /b
)

echo Extracting Misc folder to C:\Windows\...
powershell -Command "Expand-Archive -Path '%Misc_ZIP%' -DestinationPath '%TEMP%\misc_temp' -Force; Move-Item -Path '%TEMP%\misc_temp\WindowsMisc-main\*' -Destination 'C:\Windows\Misc\' -Force; Remove-Item '%TEMP%\misc_temp' -Recurse -Force"

if not exist "C:\Windows\Misc" (
    echo [!] Misc extraction failed. Exiting.
    exit /b
)

echo Misc folder extracted successfully.
del "%Misc_ZIP%" >nul 2>&1

echo Downloading Evolve folder...
set "Evolve_ZIP=%TEMP%\Evolve.zip"
curl.exe -L "https://github.com/evolveperformance/misc/raw/main/Evolve.zip" -o "%Evolve_ZIP%"

if not exist "%Evolve_ZIP%" (
    echo [!] Evolve.zip download failed. Exiting.
    exit /b
)

echo Extracting Evolve folder to C:\Windows\...
powershell -Command "Expand-Archive -Path '%Evolve_ZIP%' -DestinationPath 'C:\Windows\' -Force"

if not exist "C:\Windows\Evolve" (
    echo [!] Extraction failed. Exiting.
    exit /b
)

echo Evolve folder extracted successfully.
del "%Evolve_ZIP%" >nul 2>&1

echo Downloading latest Evolve configuration...
set "Evolve_BAT=%TEMP%\EvolveOS_Online.bat"
curl.exe -L "https://github.com/evolveperformance/misc/raw/main/EvolveOS.bat" -o "%Evolve_BAT%"

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
::echo Restarting system to apply changes...
::shutdown /r /t 5
exit /b