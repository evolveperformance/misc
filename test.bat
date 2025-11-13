@echo off

:: Auto-select option 2 (Win32, manual service)
echo 2| powershell -NoProfile -ExecutionPolicy Bypass ^
  -Command "irm 'https://raw.githubusercontent.com/Aetopia/Install-NVCPL/main/Install-NVCPL.ps1' | iex"

:: If the script failed (no NVIDIA GPU, download error, etc.), skip context menu
if errorlevel 1 goto :EOF

reg add "HKCR\DesktopBackground\Shell\NVIDIAControlPanel" ^
  /v "MUIVerb" /t REG_SZ /d "NVIDIA Control Panel" /f

reg add "HKCR\DesktopBackground\Shell\NVIDIAControlPanel" ^
  /v "Icon" /t REG_SZ /d "C:\Program Files\NVIDIA Corporation\Control Panel Client\nvcplui.exe" /f

reg add "HKCR\DesktopBackground\Shell\NVIDIAControlPanel" ^
  /v "Position" /t REG_SZ /d "Bottom" /f

reg add "HKCR\DesktopBackground\Shell\NVIDIAControlPanel\command" ^
  /ve /t REG_SZ /d "\"C:\Program Files\NVIDIA Corporation\Control Panel Client\nvcplui.exe\"" /f
