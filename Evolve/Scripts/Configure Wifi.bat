@echo off
:: Check Administrator Privileges
dism >nul 2>&1 || (echo ^<Run the script as administrator^> && pause>nul && cls&exit)

title Wi-Fi Services Control
color B
mode 45,6

:: Menu
choice /c 12 /n /m "[1] Disable Wi-Fi | [2] Enable Wi-Fi"
if %errorlevel% equ 1 (
    set "_mode=disable"
)
if %errorlevel% equ 2 (
    set "_mode=enable"
)

:: Apply Wi-Fi Configuration
if "%_mode%"=="disable" (
    echo Disabling Wi-Fi services...
    sc stop WlanSvc >nul 2>&1
    sc stop WwanSvc >nul 2>&1
    sc stop NativeWifiP >nul 2>&1

    sc config WlanSvc start=disabled >nul 2>&1
    sc config WwanSvc start=disabled >nul 2>&1
    sc config NativeWifiP start=disabled >nul 2>&1
)

if "%_mode%"=="enable" (
    echo Enabling Wi-Fi services...
    sc config WlanSvc start=auto error=ignore >nul 2>&1
    sc config WwanSvc start=auto error=ignore >nul 2>&1
    sc config NativeWifiP start=auto error=ignore >nul 2>&1

    sc start WlanSvc >nul 2>&1
    sc start WwanSvc >nul 2>&1
    sc start NativeWifiP >nul 2>&1
)

exit