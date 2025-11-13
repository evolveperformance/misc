@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=G:\GitHub Projects\Misc\EvolveOS.exe
REM BFCPEICON=
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=0
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=2.0.0.0
REM BFCPEVERPRODUCT=Product NameEvolveOS Setup Utility
REM BFCPEVERDESC=Professional Gaming Optimization Suite 
REM BFCPEVERCOMPANY=Evolve Performance
REM BFCPEVERCOPYRIGHT=Copyright � 2025 Evolve Performance
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=30
REM BFCPEWINDOWWIDTH=120
REM BFCPEWTITLE=EvolveOS Post Install - Professional Gaming Optimization
REM BFCPEOPTIONEND
@echo off
title EvolveOS Post Install - Professional Gaming Optimization v2.0
mode con: cols=170 lines=50
color B

:: ====================================================================
::                    EVOLVE OS v2.0
::          PROFESSIONAL GAMING OPTIMIZATION SUITE
::                 
::  Optimized for: Competitive FPS Gaming
::  Focus: Maximum Performance, Minimal Latency
::  Safety: Balanced (Stable + Performance)
:: ====================================================================

:: ====================================================================
:: SECTION 1: POWERSHELL POLICY & ACTIVATION
:: ====================================================================

@echo off
title EvolveOS Post Install
mode con: cols=170 lines=50
color B
taskkill /f /im explorer.exe>nul 2>&1


@echo Configuring PowerShell...
powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force >nul 2>&1
powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force >nul 2>&1
cls


@echo Start
echo Welcome to EvolveOS
echo Please wait patiently while the setup completes. Once the setup is complete your computer will restart on its own.

@echo Windows HWID Activation (Silent)
echo Set WshShell = CreateObject("WScript.Shell") > "%TEMP%\activate.vbs"
echo WshShell.Run "powershell.exe -ExecutionPolicy Bypass -Command ""& ([ScriptBlock]::Create((irm https://get.activated.win))) /HWID""", 0, True >> "%TEMP%\activate.vbs"
cscript //nologo "%TEMP%\activate.vbs"
del "%TEMP%\activate.vbs" >nul 2>&1

@echo Call Setup Bats and Visual File
call "C:\Windows\EvolveSetup\apps\evolveinstaller.bat" >nul 2>&1

@echo Thanks Nova!
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 3 /t REG_SZ /d "C:\Windows\Misc\folder.ico" /f

@echo Fix OpenShell Bug 
reg add "HKCU\Software\OpenShell\ClassicExplorer" /v Disable /t REG_DWORD /d 1 /f >nul 2>&1

:: ====================================================================
:: SECTION 2: TOOL INSTALLATION
:: ====================================================================

@echo Installing Essential Tools...
:: powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File "C:\Windows\Misc\PatchStartAllBack.ps1" >nul 2>&1
:: reg import "C:\Windows\Misc\StartAllBack.reg" >nul 2>&1
reg import "C:\Windows\Misc\RunAsTi.reg" >nul 2>&1

@echo Installing Windows Terminal...
winget install --id Microsoft.WindowsTerminal --silent --accept-source-agreements --accept-package-agreements >nul 2>&1

@echo Installing Visual Studio Code...
winget install --id Microsoft.VisualStudioCode --silent --accept-source-agreements --accept-package-agreements --override "/VERYSILENT /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath" >nul 2>&1

@echo Installing Discord...
winget install --id Discord.Discord --silent --accept-source-agreements --accept-package-agreements >nul 2>&1

@echo Creating Desktop Shortcut to Evolve App Installer...
powershell -Command ^
"$shell = New-Object -ComObject WScript.Shell; ^
$shortcut = $shell.CreateShortcut('%USERPROFILE%\Desktop\Evolve App Installer.lnk'); ^
$shortcut.TargetPath = 'C:\Windows\Evolve\Evolve App Installer.exe'; ^
$shortcut.WorkingDirectory = 'C:\Windows\Evolve'; ^
$shortcut.IconLocation = 'C:\Windows\Evolve\Evolve App Installer.exe,0'; ^
$shortcut.Description = 'Install Apps for EvolveOS'; ^
$shortcut.Save()"

@echo Setting Evolve wallpaper...
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Windows\Web\Wallpaper\EvolveBackground.png" /f
reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 10 /f
powershell -Command "$code = '[DllImport(\"user32.dll\", CharSet=CharSet.Auto)]public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);'; $type = Add-Type -MemberDefinition $code -Name WallpaperUtil -Namespace Win32 -PassThru; $type::SystemParametersInfo(0x0014, 0, 'C:\Windows\Web\Wallpaper\EvolveBackground.png', 0x03)"

@echo Fix SystemInformer TaskManager
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v Debugger /t REG_SZ /d "\"C:\Program Files\SystemInformer\SystemInformer.exe\"" /f >nul 2>&1

:: ====================================================================
:: SECTION 3: POWERSHELL CONFIGURATION
:: ====================================================================

@echo Configure PowerShell
reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d Unrestricted /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1\Shell" /ve /t REG_SZ /d Open /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\Open\Command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\WindowsPowerShell\v1.0\powershell.exe\" \"%%1\"" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs" /v HasLUAShield /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs\Command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\WindowsPowerShell\v1.0\powershell.exe\" \"%%1\"" /f >nul 2>&1
reg add "HKCR\.psm1" /ve /t REG_SZ /d Microsoft.PowerShellModule.1 /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellModule.1\Shell" /ve /t REG_SZ /d Open /f >nul 2>&1
reg add "HKCR\.psm1\OpenWithProgids" /f >nul 2>&1
reg add "HKCR\.ps1\OpenWithProgids" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" /v "EnableModuleLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v "EnableScriptBlockLogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v "EnableScriptBlockInvocationLogging" /t REG_SZ /d "" /f >nul 2>&1


@echo Add Idle Configuration to Context Menu
reg add "HKCR\DesktopBackground\Shell\Idle" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle" /v "MUIVerb" /t REG_SZ /d "Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle" /v "Position" /t REG_SZ /d "Bottom" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle" /v "SubCommands" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle001" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle001" /v "MUIVerb" /t REG_SZ /d "Disable Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle001\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle002" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle002" /v "MUIVerb" /t REG_SZ /d "Enable Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle002\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f >nul 2>&1


@echo Add Take Ownership option for folders
reg add "HKCR\Directory\shell\runas" /ve /t REG_SZ /d "Take Ownership" /f >nul 2>&1
reg add "HKCR\Directory\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Directory\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f %%1 /r /d y && icacls %%1 /grant administrators:F" /f >nul 2>&1
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f %%1 /r /d y && icacls %%1 /grant administrators:F" /f >nul 2>&1


@echo Add Nvidia container Configuration to Context Menu
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer" /v "Icon" /t REG_SZ /d "C:\Windows\Misc\nvidiaprofileinspector.exe,0" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer" /v "MUIVerb" /t REG_SZ /d "Nvidia Container" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer" /v "Position" /t REG_SZ /d "Bottom" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer" /v "SubCommands" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer\Shell\EnableNvContainer" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer\Shell\EnableNvContainer" /v "MUIVerb" /t REG_SZ /d "Enable Container" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer\Shell\EnableNvContainer\command" /ve /t REG_SZ /d "C:\Windows\Misc\NvContainerON.bat" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer\Shell\DisableNvContainer" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer\Shell\DisableNvContainer" /v "MUIVerb" /t REG_SZ /d "Disable Container" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\NvidiaContainer\Shell\DisableNvContainer\command" /ve /t REG_SZ /d "C:\Windows\Misc\NvContainerOFF.bat" /f >nul 2>&1


@echo Visuals
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9812038010000000" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "VisualFXSetting" /t REG_SZ /d "2" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v "IconsOnly" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v "ListviewAlphaSelect" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v "ListviewShadow" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /v "" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseCompactMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "ForegroundFlashCount" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCR\CABFolder\Shell\RunAs" /ve /t REG_SZ /d "Install" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax" /v DefaultValue /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations" /v DefaultValue /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMAeroPeekEnabled" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\SelectionFade" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMSaveThumbnailEnabled" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\CursorShadow" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewShadow" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ThumbnailsOrIcon" /v DefaultValue /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewAlphaSelect" /v DefaultValue /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows" /v DefaultValue /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\FontSmoothing" /v DefaultValue /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListBoxSmoothScrolling" /v DefaultValue /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DropShadow" /v DefaultValue /t REG_DWORD /d 0 /f >nul 2>&1


@echo Old cmd application
reg add "HKCU\Console\%%Startup" /v DelegationConsole /t REG_SZ /d "{B23D10C0-E52E-411E-9D5B-C09FDF709C7D}" /f >nul 2>&1
reg add "HKCU\Console\%%Startup" /v DelegationTerminal /t REG_SZ /d "{B23D10C0-E52E-411E-9D5B-C09FDF709C7D}" /f >nul 2>&1


@echo Add Install option for CAB files
reg add "HKCR\CABFolder\Shell\RunAs" /ve /t REG_SZ /d "Install" /f >nul 2>&1
reg add "HKCR\CABFolder\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\CABFolder\Shell\RunAs\Command" /ve /t REG_SZ /d "cmd /k dism /online /add-package /packagepath:\"%%1\"" /f >nul 2>&1


@echo Configure Text Files Creds: Gora
reg delete "HKCR\.txt\ShellNew" /f >nul 2>&1
reg add "HKCR\.txt\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\system32\notepad.exe,-470" /f >nul 2>&1
reg add "HKCR\.txt\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul 2>&1
reg delete "HKCR\.txt" /f >nul 2>&1
reg add "HKCR\.txt" /ve /t REG_SZ /d "txtfile" /f >nul 2>&1
reg add "HKCR\.txt" /v "Content Type" /t REG_SZ /d "text/plain" /f >nul 2>&1
reg add "HKCR\.txt" /v "PerceivedType" /t REG_SZ /d "text" /f >nul 2>&1
reg add "HKCR\.txt\PersistentHandler" /ve /t REG_SZ /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f >nul 2>&1
reg add "HKCR\.txt\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\system32\notepad.exe,-470" /f >nul 2>&1
reg add "HKCR\.txt\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.txt" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.txt" /v "PerceivedType" /t REG_SZ /d "document" /f >nul 2>&1
reg delete "HKCR\txtfile" /f >nul 2>&1
reg add "HKCR\txtfile" /ve /t REG_SZ /d "Text Document" /f >nul 2>&1
reg add "HKCR\txtfile" /v "EditFlags" /t REG_DWORD /d "2162688" /f >nul 2>&1
reg add "HKCR\txtfile" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\system32\notepad.exe,-469" /f >nul 2>&1
reg add "HKCR\txtfile\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\imageres.dll,-102" /f >nul 2>&1
reg add "HKCR\txtfile\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\NOTEPAD.EXE %%1" /f >nul 2>&1
reg add "HKCR\txtfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\NOTEPAD.EXE /p %%1" /f >nul 2>&1
reg add "HKCR\txtfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\notepad.exe /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithList" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithProgids" /v "txtfile" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\UserChoice" /v "Hash" /t REG_SZ /d "hyXk/CpboWw=" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\UserChoice" /v "ProgId" /t REG_SZ /d "txtfile" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt\UserChoice" /v "Hash" /t REG_SZ /d "FvJcqeZpmOE=" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt\UserChoice" /v "ProgId" /t REG_SZ /d "txtfile" /f >nul 2>&1




:: ====================================================================
:: SECTION 4: FILE ASSOCIATIONS (Photo Viewer)
:: ====================================================================

@echo Configure Photo Viewer
reg add "HKCU\SOFTWARE\Classes\.bmp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.cr2" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.dib" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.gif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.ico" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.jfif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.jpe" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.jpeg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.jpg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.jxr" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.png" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.tif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.tiff" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\.wdp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /d "" /f >nul 2>&1




:: ====================================================================
:: SECTION 5: FILE ASSOCIATIONS (7-Zip)
:: ====================================================================

@echo Enabling Clipboard History...
reg add "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d "1" /f >nul 2>&1

@echo Configure Context Menu
reg add "HKCR\.bat\ShellNew" /v NullFile /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\.reg\ShellNew" /v NullFile /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\.ps1\ShellNew" /v NullFile /t REG_SZ /d "" /f >nul 2>&1
reg delete "HKCR\.bmp\ShellNew" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /t REG_SZ /d "Share" /f >nul 2>&1
reg delete "HKCR\txtfile\shell\print" /f >nul 2>&1
reg delete "HKCR\regfile\shell\print" /f >nul 2>&1
reg delete "HKCR\batfile\shell\print" /f >nul 2>&1
reg delete "HKCR\*\shell\pintohomefile" /f >nul 2>&1
reg delete "HKCR\Microsoft.PowerShellScript.1\shell\print" /f >nul 2>&1
reg delete "HKCR\AcroExch.Document.DC\shell\print" /f >nul 2>&1
reg delete "HKCR\AcroExch.Document\shell\print" /f >nul 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\PreviousVersions" /f >nul 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /ve /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul 2>&1

@echo Adding Context Menu Shortcuts...
reg add "HKCR\Directory\Background\shell\RebootUEFI" /ve /t REG_SZ /d "Restart to BIOS" /f >nul 2>&1
reg add "HKCR\Directory\Background\shell\RebootUEFI" /v "Icon" /t REG_SZ /d "shell32.dll,-16739" /f >nul 2>&1
reg add "HKCR\Directory\Background\shell\RebootUEFI" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Directory\Background\shell\RebootUEFI\command" /ve /t REG_SZ /d "shutdown /r /fw /t 0" /f >nul 2>&1

@echo Desktop Settings
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeOut" /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "WindowArrangementActive" /t REG_SZ /d 0 /f >nul 2>&1


@echo Enable Windowed Optimizations
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "SwapEffectUpgradeEnable=1;" /f >nul 2>&1


@echo Disable Enumeration Policy for External Devices
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection" /v "DeviceEnumerationPolicy" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Disable DMA Remapping
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "DmaRemappingCompatible" ^| find /i "Services\"') do (
    reg add "%%i" /v "DmaRemappingCompatible" /t REG_DWORD /d 0 /f >nul 2>&1
)


@echo Tdr Delay
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDebugMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitTime" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitCount" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Disable Idle States at Boot
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableIdleStatesAtBoot" /t REG_DWORD /d "2" /f >nul 2>&1


@echo Windows Path
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "RITdemonTimerPowerSaveElapse" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "RITdemonTimerPowerSaveCoalescing" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "ProcessDCEsInUseThreshold" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "DesktopHeapLogging" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Projected Shadow Rendering
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableProjectedShadowsRendering" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Disable Spatial Audio
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableSpatialAudioGlobal" /t reg_dword /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableSpatialAudioPerEndpoint" /t reg_dword /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableSpatialAudioVssFeature" /t reg_dword /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableSpatialOnComboEndpoints" /t reg_dword /d 1 /f >nul 2>&1


@echo Configure Audio Features
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableExemptionForBCMStartupLatency" /t reg_dword /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "EnableCaptureMonitor" /t reg_dword /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableToastPolicy" /t reg_dword /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableAecStateHistory" /t reg_dword /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisablePumpBackupTimer" /t reg_dword /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t reg_dword /d 3 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v "ScreenReaderDuckingPreference" /t reg_dword /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v "AccessibilityMonoMixState" /t reg_dword /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v "MicrophonePrivacyToastFired" /t reg_dword /d 0 /f >nul 2>&1


@echo Features
DISM.exe /Online /Disable-Feature /FeatureName:"Microsoft-Hyper-V-All" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Printing-PrintToPDFServices-Features" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Printing-Foundation-Features" /NoRestart >nul 2>&1
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v 0 /t REG_DWORD /d 0 /f >nul 2>&1


@echo Disable Memory Compression and Page Combining.
powershell "Disable-MMAgent -PageCombining" >nul 2>&1
powershell "Disable-MMAgent -MemoryCompression" >nul 2>&1


@echo Graphics Drivers
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v QuantumUnit /t REG_DWORD /d 2500 /f >nul 2>&1


@echo Game DVR
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Drive
fsutil behavior set disableLastAccess 1 >nul 2>&1
fsutil behavior set disablecompression 1 >nul 2>&1
fsutil behavior set disabledeletenotify 0 >nul 2>&1
fsutil behavior set enablenonpagedntfs 1 >nul 2>&1
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set encryptpagingfile 0 >nul 2>&1
fsutil quota disable C: >nul 2>&1
schtasks /Change /Disable /TN "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableVolsnapHints" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Control Panel\International" /v "BlockCleanupOfUnusedPreinstalledLangPacks" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d 2962489444 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "StorageD3InModernStandby" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableDSTThrottle" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Classpnp" /v "NVMeDisablePerfThrottling" /t REG_DWORD /d 1 /f >nul 2>&1


@echo Disable Audit Policy
Auditpol /Remove /AllUsers >nul 2>&1
Echo Y | AuditPol /Clear >nul 2>&1
Auditpol /Set /Category:* /Success:Disable /Failure:Disable >nul 2>&1


@echo Disable Firewall
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f >nul 2>&1
reg delete "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f >nul 2>&1


@echo Disable Power Savings on Drives.
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "StorPort"^| findstr "StorPort"') do reg add "%%i" /v "EnableIdlePowerManagement" /t REG_DWORD /d "0" /f >nul 2>&1


:: @echo Branding
:: bcdedit /set {current} description "EvolveOS" >nul 2>&1
:: label C: EvolveOS >nul 2>&1
:: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "DisplayVersion" /t REG_SZ /d "EvolveOS 25H2 IOT" /f >nul 2>&1
:: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "DisplayVersion" /t REG_SZ /d "EvolveOS Windows 11 25H2 IOT" /f >nul 2>&1
:: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "DisplayNotRetailReady" /t REG_DWORD /d 0 /f >nul 2>&1
:: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOrganization /t REG_SZ /d "" /f >nul 2>&1
:: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /t REG_SZ /d "EvolveOS" /f >nul 2>&1


@echo MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 10 /f >nul 2>&1




:: ====================================================================
:: SECTION 11: SERVICE OPTIMIZATION
:: ====================================================================

@echo Configuring Windows Services...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpipagr" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AcpiPmi" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpitime" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bam" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dam" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagtrack" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dps" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dusmsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DSSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpmt" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kdnic" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\McpManagementService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pcasvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pla" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintDeviceConfigurationService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintScanBrokerService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\printworkflowusersvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PRM" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\spooler" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\troubleshootingsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbprint" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WmiAcpi" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wmiApSrv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1


@echo Disable UAC
reg add "HKLM\SYSTEM\CurrentControlSet\Services\luafv" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ValidateAdminCodeSignatures" /t REG_DWORD /d 0 /f >nul 2>&1


@echo Configure Power Path
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergySaverState" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EmiPollingInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EmiTelemetryActivePollingInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EmiTelemetryCsPollingInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PmiPollingInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "AllowAudioToEnableExecutionRequiredPowerRequests" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "AllowSystemRequiredPowerRequests" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "AlwaysComputeQosHints" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Class1InitialUnparkCount" /t REG_DWORD /d "64" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingFlushInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CustomizeDuringSetup" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DeepIoCoalescingEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableDisplayBurstOnPowerSourceChange" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableInboxPepGeneratedConstraints" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DripsSwHwDivergenceEnableLiveDump" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnableInputSuppression" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnforceAusterityMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "IdleProcessorsRequireQosManagement" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "IgnoreCsComplianceCheck" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "IpiLastClockOwnerDisable" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LidReliabilityState" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfCalculateActualUtilization" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfCheckTimerImplementation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PoFxSystemIrpWaitForReportDevicePowered" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "StandbyConnectivityGracePeriod" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TimerRebaseThresholdOnDripsExit" /t REG_DWORD /d "60" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TtmEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Win32kCalloutWatchdogTimeoutSeconds" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Enable Write Cache Buffer Flashing
for /f "delims=" %%k in ('reg Query HKLM\SYSTEM\CurrentControlSet\Enum /f "{4d36e967-e325-11ce-bfc1-08002be10318}" /d /s ^| find "HKEY"') do (
    reg add "%%k\Device Parameters\Disk" /v "UserWriteCacheSetting" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%k\Device Parameters\Disk" /v "CacheIsPowerProtected" /t REG_DWORD /d 1 /f >nul 2>&1
)


@echo Error Reporting
reg add "HKCU\Software\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Disable GameBar
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "GamePanelStartupTipIndex" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Variables to Disable Telemetry
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>&1
setx DOTNET_CLI_TELEMETRY_OPTOUT 1 >nul 2>&1


@echo Game Mode
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1


@echo Disable Timer Coalescing
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "TimerCoalescing" /t REG_BINARY /d 0000000000000000000000000000000000000000000000000000000000000000 /f >nul 2>&1


@echo Disable USB Powersavings
powershell.exe -command "Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | ForEach-Object { $_.enable = $false; $_.psbase.put(); }" >nul 2>&1
powershell -ExecutionPolicy Bypass -Command "iex ([Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aWYgKC1ub3QgKFtTZWN1cml0eS5QcmluY2lwYWwuV2luZG93c1ByaW5jaXBhbF0gW1NlY3VyaXR5LlByaW5jaXBhbC5XaW5kb3dzSWRlbnRpdHldOjpHZXRDdXJyZW50KCkpLklzSW5Sb2xlKFtTZWN1cml0eS5QcmluY2lwYWwuV2luZG93c0J1aWx0SW5Sb2xlXSAiQWRtaW5pc3RyYXRvciIpKSB7DQogICAgU3RhcnQtUHJvY2VzcyBwb3dlcnNoZWxsICItRmlsZSBgIiRQU0NvbW1hbmRQYXRoYCIiIC1WZXJiIFJ1bkFzDQogICAgZXhpdA0KfQ0KDQpmdW5jdGlvbiBEaXNhYmxlLVVTQlBvd2VyTWFuYWdlbWVudCB7DQogICAgcGFyYW0gKA0KICAgICAgICBbc3RyaW5nXSRDbGFzc05hbWUNCiAgICApDQoNCiAgICAkaHVicyA9IEdldC1XbWlPYmplY3QgLUNsYXNzICRDbGFzc05hbWUNCiAgICAkcG93ZXJNZ210ID0gR2V0LVdtaU9iamVjdCAtQ2xhc3MgTVNQb3dlcl9EZXZpY2VFbmFibGUgLU5hbWVzcGFjZSByb290XHdtaQ0KDQogICAgZm9yZWFjaCAoJHAgaW4gJHBvd2VyTWdtdCkgew0KICAgICAgICAkSU4gPSAkcC5JbnN0YW5jZU5hbWUuVG9VcHBlcigpDQogICAgICAgIGZvcmVhY2ggKCRoIGluICRodWJzKSB7DQogICAgICAgICAgICAkUE5QREkgPSAkaC5QTlBEZXZpY2VJRA0KICAgICAgICAgICAgaWYgKCRJTiAtbGlrZSAiKiRQTlBESSoiKSB7DQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiaW5mbzogY29uZmlndXJpbmcgJElOIg0KICAgICAgICAgICAgICAgICRwLmVuYWJsZSA9ICRGYWxzZQ0KICAgICAgICAgICAgICAgICRwLnBzYmFzZS5wdXQoKSB8IE91dC1OdWxsDQogICAgICAgICAgICB9DQogICAgICAgIH0NCiAgICB9DQp9DQpEaXNhYmxlLVVTQlBvd2VyTWFuYWdlbWVudCAtQ2xhc3NOYW1lICdXaW4zMl9VU0JDb250cm9sbGVyJw0KRGlzYWJsZS1VU0JQb3dlck1hbmFnZW1lbnQgLUNsYXNzTmFtZSAnV2luMzJfVVNCQ29udHJvbGxlckRldmljZScNCkRpc2FibGUtVVNCUG93ZXJNYW5hZ2VtZW50IC1DbGFzc05hbWUgJ1dpbjMyX1VTQkh1YicNCg==')))" >nul 2>&1
set "REG_PATH=HKLM\SYSTEM\CurrentControlSet\Control\usbflags"
for /f "tokens=*" %%i in ('reg query "%REG_PATH%" 2^>nul ^| findstr /r "[0-9A-F]\{12\}"') do (
    set "DEVICE_KEY=%%i"
    
    for /f "tokens=*" %%a in ("!DEVICE_KEY:%REG_PATH%\=!") do (
        set "DEVICE_ID=%%a"
        
        echo !DEVICE_ID! | findstr /r /c:"^[0-9A-F]\{12\}$" >nul 2>&1
        if !errorlevel! EQU 0 ( 
            reg add "%REG_PATH%\!DEVICE_ID!" /v "DisableLPM" /t REG_DWORD /d "1" /f >nul 2>&1
        )
    )
)
set "USB_ENUM_PATH=HKLM\SYSTEM\CurrentControlSet\Enum\USB" >nul 2>&1
for /f "tokens=*" %%d in ('reg query "%USB_ENUM_PATH%" 2^>nul') do (
    set "DEVICE_PATH=%%d"
    
    for /f "tokens=*" %%i in ('reg query "!DEVICE_PATH!" 2^>nul') do (
        set "INSTANCE_PATH=%%i"
        
            reg query "!INSTANCE_PATH!\Device Parameters" >nul 2>&1
            if !errorlevel! EQU 0 (
                reg add "!INSTANCE_PATH!\Device Parameters" /v "AllowIdleIrpInD3" /t REG_DWORD /d "0" /f >nul 2>&1
                reg add "!INSTANCE_PATH!\Device Parameters" /v "DeviceSelectiveSuspended" /t REG_DWORD /d "0" /f >nul 2>&1
                reg add "!INSTANCE_PATH!\Device Parameters" /v "IdleTimeoutPeriodInMilliSec" /t REG_DWORD /d "0" /f >nul 2>&1
                reg add "!INSTANCE_PATH!\Device Parameters" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
                reg add "!INSTANCE_PATH!\Device Parameters" /v "EnhancedPowerManagementUseMonitor" /t REG_DWORD /d "0" /f >nul 2>&1
                reg add "!INSTANCE_PATH!\Device Parameters" /v "SelectiveSuspendEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
                reg add "!INSTANCE_PATH!\Device Parameters" /v "SelectiveSuspendTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
                reg add "!INSTANCE_PATH!\Device Parameters" /v "SuppressInputInCS" /t REG_DWORD /d "0" /f >nul 2>&1
                reg add "!INSTANCE_PATH!\Device Parameters" /v "SystemInputSuppressionEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
                
                reg query "!INSTANCE_PATH!\Device Parameters\Wdf" >nul 2>&1
                if !errorlevel! EQU 0 (
                    reg add "!INSTANCE_PATH!\Device Parameters\Wdf" /v "IdleInWorkingState" /t REG_DWORD /d "0" /f >nul 2>&1
                    reg add "!INSTANCE_PATH!\Device Parameters\Wdf" /v "SleepstudyState" /t REG_DWORD /d "0" /f >nul 2>&1
                    reg add "!INSTANCE_PATH!\Device Parameters\Wdf" /v "WdfDefaultIdleInWorkingState" /t REG_DWORD /d "0" /f >nul 2>&1
                    reg add "!INSTANCE_PATH!\Device Parameters\Wdf" /v "WdfDirectedPowerTransitionChildrenOptional" /t REG_DWORD /d "0" /f >nul 2>&1
                    reg add "!INSTANCE_PATH!\Device Parameters\Wdf" /v "WdfDirectedPowerTransitionEnable" /t REG_DWORD /d "0" /f >nul 2>&1
                    reg add "!INSTANCE_PATH!\Device Parameters\Wdf" /v "WdfUseWdfTimerForPofx" /t REG_DWORD /d "0" /f >nul 2>&1
                )
            )
        )
    )
    set "ROOT_HUB_PATH=HKLM\SYSTEM\CurrentControlSet\Enum\USB\ROOT_HUB30" >nul 2>&1
    if exist "%ROOT_HUB_PATH%" (
        for /f "tokens=*" %%r in ('reg query "%ROOT_HUB_PATH%" 2^>nul') do (
            set "HUB_PATH=%%r"
            reg add "!HUB_PATH!\Device Parameters\Wdf" /v "IdleInWorkingState" /t REG_DWORD /d "0" /f >nul 2>&1
            reg add "!HUB_PATH!\Device Parameters\Wdf" /v "SleepstudyState" /t REG_DWORD /d "0" /f >nul 2>&1
            reg add "!HUB_PATH!\Device Parameters\Wdf" /v "WdfDefaultIdleInWorkingState" /t REG_DWORD /d "0" /f >nul 2>&1
            reg add "!HUB_PATH!\Device Parameters\Wdf" /v "WdfDirectedPowerTransitionChildrenOptional" /t REG_DWORD /d "0" /f >nul 2>&1
            reg add "!HUB_PATH!\Device Parameters\Wdf" /v "WdfDirectedPowerTransitionEnable" /t REG_DWORD /d "0" /f >nul 2>&1
            reg add "!HUB_PATH!\Device Parameters\Wdf" /v "WdfUseWdfTimerForPofx" /t REG_DWORD /d "0" /f >nul 2>&1
        )
    )
for %%i in (
	"EnhancedPowerManagementEnabled"
	"AllowIdleIrpInD3"
	"DeviceSelectiveSuspended"
	"DeviceResetNotificationEnabled"
	"SelectiveSuspendEnabled"
	"WaitWakeEnabled"
	"D3ColdSupported"
	"DisableD3Cold"
	"WdfDirectedPowerTransitionEnable"
	"EnableIdlePowerManagement"
	"IdleInWorkingState"
	"IdleTimeoutInMS"
	"MinimumIdleTimeoutInMS"
	"EnableHIPM"
	"EnableHDDParking"
	"EnableDIPM"
) do (
    for /f "delims=" %%k in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%~i" ^| findstr "HK"') do (
        reg add "%%k" /v "%%~i" /t reg_dword /d 0 /f >nul 2>&1
    )
)


@echo Disable Power Management
for %%i in (
	"DisableIdlePowerManagement"
	"DisableRuntimePowerManagement"
) do (
    for /f "delims=" %%k in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%~i" ^| findstr "HK"') do (
        reg add "%%k" /v "%%~i" /t reg_dword /d 1 /f >nul 2>&1
    )
)


@echo USB Flags
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v "DisableHCS0Idle" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v "Allow64KLowOrFullSpeedControlTransfers" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Wake On Input
reg add "HKLM\SYSTEM\Input" /v "WakeOnInputDeviceTypes" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Wdf
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v "WdfGlobalLogsDisabled" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Tagged Energy
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Broker Infrastructure
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "ActivityCheckTimerLowPowerPeriodMs" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "ActivityCheckTimerPeriodMs" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "AlternateCancellationTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "DisableTriggerCoalescing" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "DefaultTriggerCoalescingTime" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "EnergyBudgetDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "EnergyBudgetBgTaskPercentage" /t REG_DWORD /d "100" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "EnergyBudgetClearDebtOnFg" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "EnergyBudgetDebtCancellationDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "EnergyBudgetInfiniteOnFg" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "GlobalCoalesceMaxAdditionalTasksPerWake" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "GlobalCoalesceMaxEarlyFireWindowMs" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Disable Devices
cd C:\Windows\Misc\DevManView >nul 2>&1
DevManView /disable "Direct memory access controller" >nul 2>&1
DevManView /disable "Virtual Device Enumerator" >nul 2>&1
DevManView /disable "System speaker" >nul 2>&1
DevManView /disable "UMBus Root Bus Enumerator" >nul 2>&1
DevManView /disable "Microsoft GS Wavetable Synth" >nul 2>&1
DevManView /disable "AMD PSP" >nul 2>&1
DevManView /disable "Direct memory access controller" >nul 2>&1
DevManView /disable "Base System Device" >nul 2>&1
DevManView /disable "Composite Bus Enumerator" >nul 2>&1
DevManView /disable "System speaker" >nul 2>&1
DevManView /disable "High Precision Event Timer" >nul 2>&1
DevManView /disable "Intel Management Engine" >nul 2>&1
:: DevManView /disable "Programmable interrupt controller" >nul 2>&1
DevManView /disable "Microsoft Kernel Debug Network Adapter" >nul 2>&1
DevManView /disable "Microsoft Virtual Drive Enumerator" >nul 2>&1
DevManView /disable "Microsoft RRAS Root Enumerator" >nul 2>&1
DevManView /disable "NDIS Virtual Network Adapter Enumerator" >nul 2>&1
DevManView /disable "Numeric Data Processor" >nul 2>&1
DevManView /disable "PCI Encryption/Decryption Controller" >nul 2>&1
DevManView /disable "PCI Memory Controller" >nul 2>&1
DevManView /disable "PCI standard RAM Controller" >nul 2>&1
DevManView /disable "SM Bus Controller" >nul 2>&1
DevManView /disable "System board" >nul 2>&1
DevManView /disable "System Timer" >nul 2>&1
DevManView /disable "UMBus Root Bus Enumerator" >nul 2>&1
DevManView /disable "Unknown Device" >nul 2>&1
DevManView /disable "WAN Miniport (IKEv2)" >nul 2>&1
DevManView /disable "WAN Miniport (IP)" >nul 2>&1
DevManView /disable "WAN Miniport (IPv6)" >nul 2>&1
DevManView /disable "WAN Miniport (L2TP)" >nul 2>&1
DevManView /disable "WAN Miniport (Network Monitor)" >nul 2>&1
DevManView /disable "WAN Miniport (PPPOE)" >nul 2>&1
DevManView /disable "WAN Miniport (PPTP)" >nul 2>&1
DevManView /disable "WAN Miniport (SSTP)" >nul 2>&1
DevManView /disable "ACPI\PNP0C0C\AA" >nul 2>&1
DevManView /disable "ACPI\PNP0C14\ASUSLEDCONTROLWMI" >nul 2>&1
DevManView /disable "ACPI\PNP0C14\ASUSMBSWINTERFACE" >nul 2>&1
DevManView /disable "ACPI\PNP0C14\AOD" >nul 2>&1
DevManView /disable "ACPI\PNP0C14\AWW" >nul 2>&1
DevManView /disable "SWD\RADIO\{3DB5895D-CC28-44B3-AD3D-6F01A782B8D2}" >nul 2>&1
DevManView /disable "ROOT\SPACEPORT\0000" >nul 2>&1
DevManView /Uninstall "NVIDIA Virtual Audio Device (Wave Extensible) (WDM)" >nul 2>&1
DevManView /Uninstall "NvModuleTracker Device" >nul 2>&1


@echo Sticky Keys
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f >nul 2>&1


@echo Scheduled Tasks
schtasks /Change /TN "\Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Manual)" /DISABLE >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Application Experience\MareBackup" /F >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\SdbinstMergeDbTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\ApplicationData\appuriverifierdaily" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\ApplicationData\appuriverifierinstall" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\ApplicationData\CleanupTemporaryState" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\ApplicationData\DsSvcCleanup" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\AppListBackup\Backup" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\AppListBackup\BackupNonMaintenance" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\BitLocker\BitLocker Encrypt All Drives" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\BitLocker\BitLocker MDM policy Refresh" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Chkdsk\ProactiveScan" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\CloudRestore\Backup" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\CloudRestore\Restore" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Containers\CmCleanup" /DISABLE >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /F >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Check And Scan" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan for Crash Recovery" /DISABLE >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\DeviceDirectoryClient" /F >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Device Setup\Metadata Refresh" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\DiskFootprint\Diagnostics" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\DiskFootprint\StorageSense" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\EDP\StorageCardEncryption Task" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\BootstrapUsageDataReporting" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataReceiver" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Flighting\OneSettings\RefreshCache" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Input\InputSettingsRestoreDataAvailable" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Input\LocalUserSyncDataAvailable" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Input\MouseSyncDataAvailable" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Input\PenSyncDataAvailable" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Input\syncpensettings" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Input\TouchPadSyncDataAvailable" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdates" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\InstallService\SmartRetry" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Kernel\La57Cleanup" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Location\Notifications" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Location\WindowsActionDialog" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Management\Provisioning\Cellular" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Management\Provisioning\Logon" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" /DISABLE >nul 2>&1
schtasks /Delete /TN "\MicrosoftEdgeUpdateTaskMachineCore" /F >nul 2>&1
schtasks /Delete /TN "\MicrosoftEdgeUpdateTaskMachineUA" /F >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\PerformanceTrace\RequestTrace" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\PI\Sqm-Tasks" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Printing\EduPrintProv" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Printing\PrinterCleanupTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Printing\PrintJobCleanupTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\PushToInstall\LoginCheck" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\PushToInstall\Registration" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Ras\MobilityManager" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\ReFsRedupSvc\Initialization" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Registry\RegIdleBackup" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\RetailDemo\CleanupOfflineContent" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Security\Pwdless\IntelligentPwdlessTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\SettingSync\BackgroundUploadTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\SettingSync\NetworkStateChangeTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitor" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Shell\IndexerAutomaticMaintenance" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Shell\sSyncedImageDownload" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Shell\ThemesSyncedImageDownload" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\SpacePort\SpaceAgentTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\SpacePort\SpaceManagerTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\StateRepository\MaintenanceTasks" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Sustainability\PowerGridForecastTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Sustainability\SustainabilityTelemetry" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Sysmain\ResPriStaticDbSync" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Task Manager\Interactive" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Report Policies" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_LicenseAccepted" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate" /DISABLE >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /F >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UPnP\UPnPHostConfig" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\USB\Usb-Notifications" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WaaSMedic\PerformRemediation" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WDI\ResolutionHost" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\Refresh Group Policy Cache" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Wininet\CacheTask" /DISABLE >nul 2>&1



@echo Svc Host Split Threshold
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "4294967295" /f >nul 2>&1


@echo Power Throtting
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Hibernation
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "AllowHibernate" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabledDefault" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateChecksummingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SkipHibernateMemoryMapValidation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HiberFileSizePercent" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnableMinimalHiberFile" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ForceHibernateDisabled" /v "Policy" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg -h off


@echo Disable Sleep Study
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDeviceAccountingLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepstudyAccountingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v "WdfGlobalSleepStudyDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:false >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>&1
icacls "C:\Windows\System32\SleepStudy" /remove:g SYSTEM >nul 2>&1
icacls "C:\Windows\System32\SleepStudy" /remove:g Administrators >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v "WdfGlobalSleepStudyDisabled" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Disable Modern Standby
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformRoleOverride" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MSDisabled" /t REG_DWORD /d 1 /f >nul 2>&1


@echo Kernel
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "TimerCheckFlags" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SerializeTimerExpiration" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableControlFlowGuardXfg" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d 1 /f >nul 2>&1
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "HyperStartDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ThreadDpcEnable" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Configuration Manager
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "BugcheckRecoveryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1


@echo Power
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "WatchdogResumeTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "WatchdogSleepTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "Win32CalloutWatchdogBugcheckEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "IdleScanInterval" /t REG_DWORD /d 0 /f >nul 2>&1


@echo I/O System
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "DisableDiskCounters" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "IoAllowLoadCrashDumpDriver" /t REG_DWORD /d 0 /f >nul 2>&1


@echo Memory Path Config
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul 2>&1

@echo Memory Management (32GB+ RAM Only)
for /f "tokens=2 delims==" %%i in ('wmic computersystem get TotalPhysicalMemory /value 2^>nul') do set /a RAMMB=%%i/1048576

if not defined RAMMB (
    for /f "tokens=*" %%i in ('powershell -nop -c "[math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum/1MB)"') do set RAMMB=%%i
)

if not defined RAMMB (
    echo [!] Could not detect RAM size. Skipping DisablePagingExecutive.
    goto :skip_ram_config
)

if %RAMMB% GEQ 32768 (
    echo Enabling DisablePagingExecutive - System has %RAMMB%MB RAM
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f >nul 2>&1
) else (
    echo Skipping DisablePagingExecutive - System only has %RAMMB%MB RAM (32GB+ required)
)

:skip_ram_config

@echo Additional Memory Tweaks
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePageCombining" /t REG_DWORD /d 1 /f >nul 2>&1




:: ====================================================================
:: SECTION 7: CORE PERFORMANCE REGISTRY TWEAKS
:: ====================================================================

@echo [1/15] Win32 Priority Separation (Gaming Optimized)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "26" /f >nul 2>&1



@echo [2/15] System Reliability ^& Error Reporting
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1



@echo [3/15] Prefetch ^& Superfetch Optimization
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f >nul 2>&1



@echo [4/15] Maintenance Scheduler
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul 2>&1



@echo [5/15] Input Device Buffer Optimization (High Polling Rate)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d 20 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 20 /f >nul 2>&1



@echo [6/15] Storage Latency Optimization
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters" /v "IoLatencyCap" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v "IoLatencyCap" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\secnvmei\Parameters" /v "IoLatencyCap" /t REG_DWORD /d 0 /f >nul 2>&1



@echo [7/15] Desktop Window Manager (DWM)
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MPCInputRouterWaitForDebugger" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "UseHWDrawListEntriesOnWARP" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "SuperWetEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OptimizeForDirtyExpressions" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "LogExpressionPerfStats" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "InteractionOutputPredictionDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableResizeOptimization" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableMPCPerfCounter" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableMegaRects" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableFrontBufferRenderChecks" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableEffectCaching" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableDesktopOverlays" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableHologramCompositor" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableDrawListCaching" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "AnimationAttributionHashingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "AnimationAttributionEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableProjectedShadows" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisallowAnimations" /t REG_DWORD /d 1 /f >nul 2>&1



@echo [8/15] Graphics Driver Optimization
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MiracastForceDisable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableWDDM23Synchronization" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableFuzzing" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableDecodeMPO" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableMultiSourceMPOCheck" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableLddmSpriteTearDown" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableIndependentVidPnVSync" /t REG_DWORD /d 1 /f >nul 2>&1



@echo [9/15] Session Manager Configuration
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "AlpcWakePolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "FastBoot" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "SelfHealingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "VirtualizationEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "EnablePeriodicBackup" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "WorkerFactoryThreadIdleTimeout" /t REG_DWORD /d 1 /f >nul 2>&1
:: EXPERIMENT
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "ForceEnableMutantAutoboost" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "Mirroring" /t REG_DWORD /d 0 /f >nul 2>&1



@echo [10/15] Kernel Configuration
:: EXPERIMENT
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcQueueDepth" /t REG_DWORD /d 1 /f >nul 2>&1
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MaximumSharedReadyQueueSize" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableTsx" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CacheIsoBitmap" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d 222222222222222222222222222222222222222222222222 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d 222222222222222222222222222222222222222222222222 /f >nul 2>&1
:: EXPERIMENT
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ForceIdleGracePeriod" /t REG_DWORD /d 0 /f >nul 2>&1
:: REMOVED for stability (extra CPU overhead)
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "AlwaysTrackIoBoosting" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "PowerOffFrozenProcessors" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "InterruptSteeringFlags" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SeLpacEnableWatsonReporting" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SeLpacEnableWatsonThrottling" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "EnableWerUserReporting" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SchedulerAssistThreadFlagOverride" /t REG_DWORD /d 1 /f >nul 2>&1



@echo [11/15] Power Management  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateBootOptimizationEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ThermalTelemetryVerbosity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "FxAccountingTelemetryDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfBoostAtGuaranteed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceIdleResiliency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "IdleDurationExpirationTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HeteroMultiCoreClassesEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HeteroMultiClassParkingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HeteroHgsPlusDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ActiveIdleTimeout" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "IdleStateTimeout" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfQueryOnDevicePowerChanges" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "EnableDsNetRefresh" /t REG_DWORD /d 0 /f >nul 2>&1



:: ====================================================================
:: SECTION 8: ADDITIONAL SYSTEM TWEAKS
:: ====================================================================

@echo Applying Additional Tweaks...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "HyperStartDisabled" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1

@echo Autoruns
reg add "HKCU\Software\Sysinternals\AutoRuns" /v EulaAccepted /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v AlwaysOnTop /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v CheckVirusTotal /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v HideEmptyEntries /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v HideMicrosoftEntries /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v HideVirusTotalCleanEntries /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v HideWindowsEntries /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v ScanOnlyPerUserLocations /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v SubmitUnknownImages /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v Theme /t REG_SZ /d "DarkTheme" /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\AutoRuns" /v VerifyCodeSignatures /t REG_DWORD /d 1 /f >nul 2>&1

@echo Disable Windows Store Auto Download
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d "2" /f >nul 2>&1

@echo Taskbar Widgets off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1

@echo Exclude Driver Updates in Quality Updates
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1

@echo Prevent Device Metadata From Network
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f >nul 2>&1

@echo Configure Windows Update Options
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f >nul 2>&1

@echo Disable Delivery Optimization
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1

@echo Disable Driver Search from Windows Update
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d "1" /f >nul 2>&1

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

::@echo Install Modded NVMe Driver
::
::set "NVME_PATH=C:\Windows\Evolve\Drivers\NVME Modded Driver"
::set "CERT_CMD=%NVME_PATH%\Certificate\Import Win-RAID CA.cmd"
::set "DRIVER_INF=%NVME_PATH%\Driver\secnvme.inf"
::
::if exist "%CERT_CMD%" (
::    if exist "%DRIVER_INF%" (
::        echo [+] Installing Win-RAID CA Certificate...
::        pushd "%NVME_PATH%\Certificate"
::        call "Import Win-RAID CA.cmd" >nul 2>&1
::        popd
::        
::        timeout /t 2 /nobreak >nul
::        
::        echo [+] Installing NVMe modded driver...
::        pnputil /add-driver "%DRIVER_INF%" /install /subdirs >nul 2>&1
::        
::        if %errorlevel% equ 0 (
::            echo [✓] NVMe modded driver installed successfully.
::        ) else (
::            echo [!] NVMe driver installation failed. May already be installed or hardware not detected.
::        )
::    ) else (
::        echo [!] Driver INF not found.
::    )
::) else (
::    echo [!] NVMe modded driver not found. Skipping.
::)

@echo Edge
reg add "HKLM\Software\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "AllowPrelaunch" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Background Apps 
reg add "HKLM\Software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Remove Shortcut Text
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /v "ShortcutNameTemplate" /t REG_SZ /d "\"%s.lnk\"" /f >nul 2>&1


@echo Show Hidden Files and File Extensions
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Remove SendTo Context Menu
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" /f >nul 2>&1
reg delete "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo" /f >nul 2>&1


@echo Block Cast To Device
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /t REG_SZ /d "" /f >nul 2>&1


@echo Remove Extract All Context Menu
reg delete "HKCR\CompressedFolder\ShellEx\ContextMenuHandlers\{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.zip\ShellEx\ContextMenuHandlers\{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}" /f >nul 2>&1


@echo Disable Location Sensors
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v "AllowFindMyDevice" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v "LocationSyncEnabled" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Remove Give Access To Context Menu
reg delete "HKCR\*\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1


@echo Remove Include in Library Context Menu
reg delete "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f >nul 2>&1


@echo Disable Map Network Drive/Disconnect Network Drive
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoNetConnectDisconnect" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoNetConnectDisconnect" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Remove New RTF
reg delete "HKCR\.rtf\ShellNew" /f >nul 2>&1


@echo Remove Previous Versions
reg delete "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "NoPreviousVersionsPage" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\PreviousVersions" /v "DisableLocalPage" /f >nul 2>&1


@echo Search Settings
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsAADCloudSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsMSACloudSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "SafeSearchMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "EnableDynamicContentInWSB" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDynamicSearchBoxEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f >nul 2>&1


@echo Lightning
reg add "HKCU\Software\Microsoft\Lighting" /v "AmbientLightingEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Lighting" /v "ControlledByForegroundApp" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Mouse Control Panel
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "RawMouseThrottleEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "RawMouseThrottleForced" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "RawMouseThrottleDuration" /t REG_DWORD /d 20 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "RawMouseThrottleLeeway" /t REG_DWORD /d 0 /f >nul 2>&1


@echo Sync
reg add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f >nul 2>&1


@echo Disable Wake on Input
reg add "HKLM\SYSTEM\Input" /v "WakeOnInputDeviceTypes" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Rebuild Performance Counters
lodctr /r >nul 2>&1
lodctr /r >nul 2>&1
winmgmt /resyncperf >nul 2>&1

:: Unbind print screen key from Snipping Tool
reg add "HKCU\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Sound
reg add "HKCU\AppEvents\Schemes" /v "" /t REG_SZ /d ".None" /f
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d "3" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /v DisableStartupSound /t REG_DWORD /d 1 /f

:: BLANK.ICO 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "C:\Program Files\ENVY\Files\Visuals\blank.ico" /f


:: ====================================================================
:: SECTION 9: NETWORK OPTIMIZATION
:: ====================================================================

@echo Optimizing Network Adapters...
for /f %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr  "HKEY"') do (
    for /f %%i in ('reg query "%%a" /v "*ReceiveBuffers" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*ReceiveBuffers" /t REG_SZ /d "2048" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TransmitBuffers" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*TransmitBuffers" /t REG_SZ /d "1024" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePME" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnablePME" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*DeviceSleepOnDisconnect" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*EEE" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*ModernStandbyWoLMagicPacket" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*ModernStandbyWoLMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*SelectiveSuspend" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*SelectiveSuspend" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*WakeOnMagicPacket" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*WakeOnPattern" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*WakeOnPattern" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "AutoPowerSaveModeEnabled" ^| findstr "HKEY"') do (
        reg add "%%i" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*DeviceSleepOnDisconnect" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EEELinkAdvertisement" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EEELinkAdvertisement" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EeePhyEnable" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EeePhyEnable" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableGreenEthernet" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableModernStandby" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnableModernStandby" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "GigaLite" ^| findstr "HKEY"') do (
        reg add "%%i" /v "GigaLite" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PnPCapabilities" ^| findstr "HKEY"') do (
        reg add "%%i" /v "PnPCapabilities" /t REG_DWORD /d "24" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerDownPll" ^| findstr "HKEY"') do (
        reg add "%%i" /v "PowerDownPll" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerSavingMode" ^| findstr "HKEY"') do (
        reg add "%%i" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ReduceSpeedOnPowerDown" ^| findstr "HKEY"') do (
        reg add "%%i" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "S5WakeOnLan" ^| findstr "HKEY"') do (
        reg add "%%i" /v "S5WakeOnLan" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "SavePowerNowEnabled" ^| findstr "HKEY"') do (
        reg add "%%i" /v "SavePowerNowEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ULPMode" ^| findstr "HKEY"') do (
        reg add "%%i" /v "ULPMode" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnLink" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WakeOnLink" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnSlot" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WakeOnSlot" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeUpModeCap" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WakeUpModeCap" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WaitAutoNegComplete" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WaitAutoNegComplete" /t REG_SZ /d "0" /f
    )
    for /f %%i in ('reg query "%%a" /v "*FlowControl" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*FlowControl" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WolShutdownLinkSpeed" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnMagicPacketFromS5" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WakeOnMagicPacketFromS5" /t REG_SZ /d "2" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WolShutdownLinkSpeed" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PMNSOffload" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*PMNSOffload" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PMARPOffload" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*PMARPOffload" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*NicAutoPowerSaver" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*NicAutoPowerSaver" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PMWiFiRekeyOffload" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*PMWiFiRekeyOffload" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePowerManagement" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnablePowerManagement" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ForceWakeFromMagicPacketOnModernStandby" ^| findstr "HKEY"') do (
        reg add "%%i" /v "ForceWakeFromMagicPacketOnModernStandby" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeFromS5" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WakeFromS5" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOn" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WakeOn" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "OBFFEnabled" ^| findstr "HKEY"') do (
        reg add "%%i" /v "OBFFEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "DMACoalescing" ^| findstr "HKEY"') do (
        reg add "%%i" /v "DMACoalescing" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableSavePowerNow" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnableSavePowerNow" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableD0PHYFlexibleSpeed" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnableD0PHYFlexibleSpeed" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePHYWakeUp" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnablePHYWakeUp" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePHYFlexibleSpeed" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnablePHYFlexibleSpeed" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "AllowAllSpeedsLPLU" ^| findstr "HKEY"') do (
        reg add "%%i" /v "AllowAllSpeedsLPLU" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*EnableDynamicPowerGating" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*EnableDynamicPowerGating" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableD3ColdInS0" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnableD3ColdInS0" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "LatencyToleranceReporting" ^| findstr "HKEY"') do (
        reg add "%%i" /v "LatencyToleranceReporting" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableAspm" ^| findstr "HKEY"') do (
        reg add "%%i" /v "EnableAspm" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "LTROBFF" ^| findstr "HKEY"') do (
        reg add "%%i" /v "LTROBFF" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "S0MgcPkt" ^| findstr "HKEY"') do (
        reg add "%%i" /v "S0MgcPkt" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*TCPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv6" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*TCPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPConnectionOffloadIPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*TCPConnectionOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPConnectionOffloadIPv6" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*TCPConnectionOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPUDPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*TCPUDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPUDPChecksumOffloadIPv6" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*TCPUDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*UDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv6" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*UDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UdpRsc" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*UdpRsc" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "**UsoIPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*UsoIPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UsoIPv6" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*UsoIPv6" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*RscIPv6" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*RscIPv6" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*RscIPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*RscIPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*IPsecOffloadV2IPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*IPsecOffloadV2IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*IPsecOffloadV2" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*IPsecOffloadV2" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*IPsecOffloadV1IPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*IPsecOffloadV1IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*LsoV1IPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*LsoV1IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*LsoV2IPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*LsoV2IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*LsoV2IPv6" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*LsoV2IPv6" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*IPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*IPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeFromPowerOff" ^| findstr "HKEY"') do (
        reg add "%%i" /v "WakeFromPowerOff" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "LogLinkStateEvent" ^| findstr "HKEY"') do (
        reg add "%%i" /v "LogLinkStateEvent" /t REG_SZ /d "16" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*InterruptModeration" ^| findstr "HKEY"') do (
        reg add "%%i" /v "*InterruptModeration" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ITR" ^| findstr "HKEY"') do (
        reg add "%%i" /v "ITR" /t REG_SZ /d "0" /f >nul 2>&1
    )
) >nul 2>&1


@echo Int Delay's
for %%a in (TxIntDelay TxAbsIntDelay RxIntDelay RxAbsIntDelay) do (
    for /f "delims=" %%b in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "*SpeedDuplex" ^| findstr "HKEY"') do (
        reg add "%%b" /v "%%a" /t REG_SZ /d "0" /f >nul 2>&1
    )
)




:: ====================================================================
:: SECTION 9: NETWORK OPTIMIZATION
:: ====================================================================

@echo Optimizing Network Adapters... Binding
powershell Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_lldp; Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_msclient; Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_lltdio; Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_implat; Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_rspndr; Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_server >nul 2>&1




:: ====================================================================
:: SECTION 9: NETWORK OPTIMIZATION
:: ====================================================================

@echo Optimizing Network Adapters... Coalescing
powershell Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing Enable >nul 2>&1
powershell Set-NetOffloadGlobalSetting -PacketCoalescingFilter Disable >nul 2>&1


@echo BBr2
netsh int ipv6 set gl loopbacklargemtu=disable >nul 2>&1
netsh int ipv4 set gl loopbacklargemtu=disable >nul 2>&1
netsh int tcp set supplemental Template=Internet CongestionProvider=bbr2 >nul 2>&1
netsh int tcp set supplemental Template=Datacenter CongestionProvider=bbr2 >nul 2>&1
netsh int tcp set supplemental Template=Compat CongestionProvider=bbr2 >nul 2>&1
netsh int tcp set supplemental Template=DatacenterCustom CongestionProvider=bbr2 >nul 2>&1
netsh int tcp set supplemental Template=InternetCustom CongestionProvider=bbr2 >nul 2>&1


@echo Netsh Configuration
netsh int udp set global uro=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set security mpp=disabled >nul 2>&1
netsh int tcp set security profiles=disabled >nul 2>&1
netsh int ipv6 6to4 set state disabled >nul 2>&1
netsh int teredo set state disabled >nul 2>&1
netsh int isatap set state disabled >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
netsh int tcp set heuristics wsh=disabled >nul 2>&1


@echo NDIS
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" /v "TrackNblOwner" /t REG_DWORD /d "0" /f >nul 2>&1


@echo Configure QoS Packet Scheduler
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "TimerResolution" /t REG_DWORD /d 1 /f >nul 2>&1


@echo Disable Nagle Algorithm
for /f "tokens=*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
	reg add "%%A" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
	reg add "%%A" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >nul 2>&1
	reg add "%%A" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
)

@echo NetBios
for /f "tokens=*" %%B in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" 2^>nul') do (
	reg add "%%B" /v "NetbiosOptions" /t REG_DWORD /d "2" /f >nul 2>&1
)


@echo Ntfs
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableVolsnapHints" /t REG_DWORD /d "1" /f >nul 2>&1

@echo Window Snapping
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SnapAssist /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableSnapAssistFlyout /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableTaskGroups /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableSnapBar /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DITest /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v WindowArrangementActive /t REG_SZ /d 1 /f >nul 2>&1

reg import "C:\Windows\Misc\EvolveTweaks.reg"

@echo FlushDns
ipconfig /flushdns >nul 2>&1

@echo Disable Wake Devices
for /f "tokens=*" %%a in ('powercfg /devicequery wake_armed 2^>nul') do powercfg /devicedisablewake "%%a" >nul 2>&1

@echo.
echo EvolveOS configuration complete!

:POWERSHELL
chcp 437 >nul 2>&1 & powershell -nop -noni -exec bypass -c %* >nul 2>&1 & chcp 65001 >nul 2>&1

:: ====================================================================
:: FINALIZATION
:: ====================================================================

@echo.
@echo ============================================================
@echo         OPTIMIZATION COMPLETE!
@echo ============================================================
@echo.
echo All optimizations have been applied successfully.

@echo Restarting Windows Explorer...
start explorer.exe
timeout /t 3 /nobreak >nul

echo EvolveOS setup completed successfully at %date% %time% > "%USERPROFILE%\Desktop\EVOLVEOS_DONE.txt"

echo.
echo Returning to launcher...
exit /b 0
