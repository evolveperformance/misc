echo Downloading Evolve folder...
set "Evolve_ZIP=%TEMP%\Evolve.zip"
curl.exe -L "https://github.com/evolveperformance/Evolve/archive/refs/heads/main.zip" -o "%Evolve_ZIP%"

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

@echo Create Desktop Shortcut to Evolve Folder
powershell -Command ^
"$shell = New-Object -ComObject WScript.Shell; ^
$shortcut = $shell.CreateShortcut('%USERPROFILE%\Desktop\Evolve.lnk'); ^
$shortcut.TargetPath = 'C:\Windows\Evolve'; ^
$shortcut.IconLocation = 'C:\Windows\System32\imageres.dll,3'; ^
$shortcut.Save()"