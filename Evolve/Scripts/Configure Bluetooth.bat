@echo off
:: Check Administrator Privileges
dism >nul 2>&1 || (echo ^<Run the script as administrator^> && pause>nul && cls&exit)

title Bluetooth Services Control
color B
mode 45,6

:: Menu
choice /c 12 /n /m "[1] Disable Bluetooth | [2] Enable Bluetooth"
if %errorlevel% equ 1 (
    set "_mode=disable"
)
if %errorlevel% equ 2 (
    set "_mode=enable"
)

:: Apply Bluetooth Configuration
if "%_mode%"=="disable" (
    echo Disabling Bluetooth services...

    sc config bthserv start=disabled >nul 2>&1
    sc config BluetoothUserService start=disabled >nul 2>&1
    sc config BTAGService start=disabled >nul 2>&1
    sc config BthAvctpSvc start=disabled >nul 2>&1
    sc config HidBth start=disabled >nul 2>&1
    sc config Microsoft_Bluetooth_AvrcpTransport start=disabled >nul 2>&1
    sc config BthEnum start=disabled >nul 2>&1
    sc config BthHFEnum start=disabled >nul 2>&1
    sc config BthLEEnum start=disabled >nul 2>&1
    sc config BthMini start=disabled >nul 2>&1
    sc config BTHMODEM start=disabled >nul 2>&1
    sc config BTHPORT start=disabled >nul 2>&1
    sc config BTHUSB start=disabled >nul 2>&1
    sc config RFCOMM start=disabled >nul 2>&1

    sc stop bthserv >nul 2>&1
    sc stop BluetoothUserService >nul 2>&1
    sc stop BTAGService >nul 2>&1
    sc stop BthAvctpSvc >nul 2>&1
    sc stop HidBth >nul 2>&1
    sc stop Microsoft_Bluetooth_AvrcpTransport >nul 2>&1
    sc stop BthEnum >nul 2>&1
    sc stop BthHFEnum >nul 2>&1
    sc stop BthLEEnum >nul 2>&1
    sc stop BthMini >nul 2>&1
    sc stop BTHMODEM >nul 2>&1
    sc stop BTHPORT >nul 2>&1
    sc stop BTHUSB >nul 2>&1
    sc stop RFCOMM >nul 2>&1
)

if "%_mode%"=="enable" (
    echo Enabling Bluetooth services...

    sc config bthserv start=auto >nul 2>&1
    sc config BluetoothUserService start=auto >nul 2>&1
    sc config BTAGService start=demand >nul 2>&1
    sc config BthAvctpSvc start=demand >nul 2>&1
    sc config HidBth start=demand >nul 2>&1
    sc config Microsoft_Bluetooth_AvrcpTransport start=demand >nul 2>&1
    sc config BthEnum start=demand >nul 2>&1
    sc config BthHFEnum start=demand >nul 2>&1
    sc config BthLEEnum start=demand >nul 2>&1
    sc config BthMini start=demand >nul 2>&1
    sc config BTHMODEM start=demand >nul 2>&1
    sc config BTHPORT start=demand >nul 2>&1
    sc config BTHUSB start=demand >nul 2>&1
    sc config RFCOMM start=demand >nul 2>&1

    sc start bthserv >nul 2>&1
    sc start BluetoothUserService >nul 2>&1
    sc start BTAGService >nul 2>&1
    sc start BthAvctpSvc >nul 2>&1
    sc start HidBth >nul 2>&1
    sc start Microsoft_Bluetooth_AvrcpTransport >nul 2>&1
    sc start BthEnum >nul 2>&1
    sc start BthHFEnum >nul 2>&1
    sc start BthLEEnum >nul 2>&1
    sc start BthMini >nul 2>&1
    sc start BTHMODEM >nul 2>&1
    sc start BTHPORT >nul 2>&1
    sc start BTHUSB >nul 2>&1
    sc start RFCOMM >nul 2>&1
)

exit
