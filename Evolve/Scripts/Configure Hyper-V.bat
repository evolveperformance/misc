@echo off
:: Check Administrator Privileges
bcdedit >nul 2>&1 || (echo ^<Run the script as administrator^> && pause>nul && cls & exit)
title Set Hyper-V
color B
mode 40,4

cd C:\Windows\Misc\DevManView

choice /c 12 /n /m "[1] Disable Hyper-V | [2] Enable Hyper-V"

if %errorlevel% equ 1 (
    bcdedit /set {hypervisorsettings} hypervisorlaunchtype Off >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisordebug >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisorenforcedcodeintegrity >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisormsrfilterpolicy >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisormmionxpolicy >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisordebugtype >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisordisableslat >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisorusevapic >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisornumproc >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisordebugpages >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisoruselargevtlb >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} hypervisoriommupolicy >nul 2>&1
    bcdedit /deletevalue {hypervisorsettings} vsmlaunchtype >nul 2>&1
    bcdedit /deletevalue hypervisorloadoptions >nul 2>&1
    if not exist "DevManView.exe" (
      echo DevManView.exe not found in this folder.
      pause
    )
    DevManView.exe /disable "Microsoft Hyper-V Virtualization Infrastructure Driver"
)

if %errorlevel% equ 2 (
    bcdedit /set hypervisorlaunchtype auto >nul
    if not exist "DevManView.exe" (
      echo DevManView.exe not found in this folder.
      pause
    )
    DevManView.exe /enable "Microsoft Hyper-V Virtualization Infrastructure Driver"
)

exit
