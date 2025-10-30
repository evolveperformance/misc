@echo off
:: Check Administrator Privileges
dism >nul 2>&1 || (echo ^<Run the script as administrator^> && pause>nul && cls&exit)

title SmartScreen Configuration
color B
mode 55,6

:: Menu
choice /c 12 /n /m "[1] Disable SmartScreen | [2] Re-enable SmartScreen"
if %errorlevel% equ 1 (
    set "_mode=disable"
)
if %errorlevel% equ 2 (
    set "_mode=enable"
)

:: Disable SmartScreen
if "%_mode%"=="disable" (
    reg add "HKCU\SOFTWARE\Microsoft\Edge\SmartScreenEnabled" /ve /t REG_DWORD /d "0" /f >nul 2>&1
    taskkill /f /im smartscreen.exe >nul 2>&1
    ren "C:\Windows\System32\smartscreen.exe" smartscreen.old >nul 2>&1
    echo SmartScreen has been disabled.
)

:: Re-enable SmartScreen
if "%_mode%"=="enable" (
    reg add "HKCU\SOFTWARE\Microsoft\Edge\SmartScreenEnabled" /ve /t REG_DWORD /d "1" /f >nul 2>&1
    if exist "C:\Windows\System32\smartscreen.old" (
        ren "C:\Windows\System32\smartscreen.old" smartscreen.exe >nul 2>&1
        echo SmartScreen has been re-enabled.
    ) else (
        echo SmartScreen is already enabled or backup file not found.
    )
)

exit
