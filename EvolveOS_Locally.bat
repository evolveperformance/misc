@echo off
title Evolve OS Setup

:: TESTING MODE - Downloads disabled

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: INTERNET CHECK DISABLED FOR TESTING
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: :checkInternet
:: echo Checking internet connection...
:: ping -n 1 8.8.8.8 >nul 2>&1
:: if errorlevel 1 (
::     echo No internet connection. Retrying in 5 seconds...
::     timeout /t 5 /nobreak >nul
::     goto checkInternet
:: )
:: echo Internet connection detected.

echo [TEST MODE] Skipping internet check...

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: MISC FOLDER DOWNLOAD DISABLED FOR TESTING
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: echo Downloading Misc folder...
:: set "Misc_ZIP=%TEMP%\WindowsMisc.zip"
:: curl.exe -L "https://github.com/evolveperformance/WindowsMisc/archive/refs/heads/main.zip" -o "%Misc_ZIP%"
:: if not exist "%Misc_ZIP%" (
::     echo [!] WindowsMisc.zip download failed. Exiting.
::     exit /b
:: )
:: echo Extracting Misc folder to C:\Windows\...
:: powershell -Command "Expand-Archive -Path '%Misc_ZIP%' -DestinationPath '%TEMP%\misc_temp' -Force; Move-Item -Path '%TEMP%\misc_temp\WindowsMisc-main\*' -Destination 'C:\Windows\Misc\' -Force; Remove-Item '%TEMP%\misc_temp' -Recurse -Force"
:: if not exist "C:\Windows\Misc" (
::     echo [!] Misc extraction failed. Exiting.
::     exit /b
:: )
:: echo Misc folder extracted successfully.
:: del "%Misc_ZIP%" >nul 2>&1

echo [TEST MODE] Skipping WindowsMisc download/extraction...

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: EVOLVE FOLDER DOWNLOAD DISABLED FOR TESTING
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: echo Downloading Evolve folder...
:: set "Evolve_ZIP=%TEMP%\Evolve.zip"
:: curl.exe -L "https://github.com/evolveperformance/Evolve/archive/refs/heads/main.zip" -o "%Evolve_ZIP%"
:: if not exist "%Evolve_ZIP%" (
::     echo [!] Evolve.zip download failed. Exiting.
::     exit /b
:: )
:: echo Extracting Evolve folder to C:\Windows\...
:: powershell -Command "Expand-Archive -Path '%Evolve_ZIP%' -DestinationPath '%TEMP%\evolve_temp' -Force; Move-Item -Path '%TEMP%\evolve_temp\Evolve-main' -Destination 'C:\Windows\Evolve' -Force; Remove-Item '%TEMP%\evolve_temp' -Recurse -Force"
:: if not exist "C:\Windows\Evolve" (
::     echo [!] Extraction failed. Exiting.
::     exit /b
:: )
:: echo Evolve folder extracted successfully.
:: del "%Evolve_ZIP%" >nul 2>&1

echo [TEST MODE] Skipping Evolve folder download/extraction...

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: DESKTOP SHORTCUT DISABLED FOR TESTING
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: @echo Create Desktop Shortcut to Evolve Folder
:: powershell -Command ^
:: "$shell = New-Object -ComObject WScript.Shell; ^
:: $shortcut = $shell.CreateShortcut('%USERPROFILE%\Desktop\Evolve.lnk'); ^
:: $shortcut.TargetPath = 'C:\Windows\Evolve'; ^
:: $shortcut.IconLocation = 'C:\Windows\System32\imageres.dll,3'; ^
:: $shortcut.Save()"

echo [TEST MODE] Skipping desktop shortcut creation...

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: EVOLVEOS.BAT DOWNLOAD DISABLED FOR TESTING
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: echo Downloading latest Evolve configuration...
:: set "Evolve_BAT=%TEMP%\EvolveOS_Online.bat"
:: curl.exe -L "https://github.com/evolveperformance/misc/raw/main/EvolveOS.bat" -o "%Evolve_BAT%"
:: if not exist "%Evolve_BAT%" (
::     echo [!] Download failed. Exiting.
::     exit /b
:: )

echo [TEST MODE] Using local EvolveOS.bat instead of downloading...
set "Evolve_BAT=%~dp0EvolveOS.bat"

echo Running Evolve setup...
call "%Evolve_BAT%"

echo.
echo Cleaning up temporary files...
del "%Evolve_BAT%" >nul 2>&1

echo.
echo Setup completed. Returning to launcher...
exit /b 0
