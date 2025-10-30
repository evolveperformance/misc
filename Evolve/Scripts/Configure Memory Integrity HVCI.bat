@echo off
:: Check Administrator Privileges
dism >nul 2>&1 || (echo ^<Run the script as administrator^> && pause>nul && cls&exit)

title Memory Integrity configuration
color B
mode 45,6

:: Menu
choice /c 12 /n /m "[1] Disable HVCI | [2] Enable HVCI"
if %errorlevel% equ 1 (
    set "_mode=disable"
)
if %errorlevel% equ 2 (
    set "_mode=enable"
)

:: Apply Bluetooth Configuration
if "%_mode%"=="disable" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
)

if "%_mode%"=="enable" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
)

exit
