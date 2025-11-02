echo Downloading Evolve folder...
set "Evolve_ZIP=%TEMP%\Evolve.zip"
curl.exe -L "https://github.com/evolveperformance/Evolve/archive/refs/heads/main.zip" -o "%Evolve_ZIP%"

if not exist "%Evolve_ZIP%" (
    echo [!] Evolve.zip download failed. Exiting.
    exit /b
)

echo Extracting Evolve folder to C:\Windows\...
powershell -Command "Expand-Archive -Path '%Evolve_ZIP%' -DestinationPath '%TEMP%\evolve_temp' -Force; Move-Item -Path '%TEMP%\evolve_temp\Evolve-main' -Destination 'C:\Windows\Evolve' -Force; Remove-Item '%TEMP%\evolve_temp' -Recurse -Force"

if not exist "C:\Windows\Evolve" (
    echo [!] Extraction failed. Exiting.
    exit /b
)

echo Evolve folder extracted successfully.
del "%Evolve_ZIP%" >nul 2>&1
