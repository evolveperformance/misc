@echo off


@echo off
:: Check Administrator Privileges
dism >nul 2>&1 || (echo ^<Run the script as administrator^> && pause>nul && cls&exit)

title Network Settings Control
color B
mode 55,6

:: Menu
choice /c 12 /n /m "[1] Default Network | [2] Tweaked Network Settings"
if %errorlevel% equ 1 ( goto :default )
if %errorlevel% equ 2 ( goto :Tweaked )

:default
cls
netsh int ip reset >nul 2>&1
netsh interface ipv4 reset >nul 2>&1
netsh interface ipv6 reset >nul 2>&1
netsh interface tcp reset >nul 2>&1
netsh winsock reset >nul 2>&1
PowerShell -NoP -C "foreach ($dev in Get-PnpDevice -Class Net -Status 'OK') { pnputil /remove-device $dev.InstanceId }" >nul 2>&1
pnputil /scan-devices >nul 2>&1
for /f %%n in ('wmic path win32_networkadapter get GUID^| findstr "{"') do (
            reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%n" /v "TcpAckFrequency" /f >nul 2>&1
            reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%n" /v "TcpDelAckTicks" /f >nul 2>&1
            reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%n" /v "TCPNoDelay" /f >nul 2>&1
        ) >nul 2>&1
for /f "delims=" %%u in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /s /f "NetbiosOptions" ^| findstr "HKEY"') do (
    reg add "%%u" /v "NetbiosOptions" /t REG_DWORD /d "0" /f >nul 2>&1
) >nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "EnableLMHOSTS" /t REG_DWORD /d "1" /f >nul 2>&1
cls
exit

:Tweaked
cls
netsh int ip reset >nul 2>&1
netsh interface ipv4 reset >nul 2>&1
netsh interface ipv6 reset >nul 2>&1
netsh interface tcp reset >nul 2>&1
netsh winsock reset >nul 2>&1
PowerShell -NoP -C "foreach ($dev in Get-PnpDevice -Class Net -Status 'OK') { pnputil /remove-device $dev.InstanceId }" >nul 2>&1
pnputil /scan-devices >nul 2>&1
for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr  "HKEY"') do (
    for /f %%i in ('reg query "%%a" /v "EnablePME" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnablePME" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*DeviceSleepOnDisconnect" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*EEE" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*ModernStandbyWoLMagicPacket" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*ModernStandbyWoLMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*SelectiveSuspend" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*SelectiveSuspend" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*WakeOnMagicPacket" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*WakeOnPattern" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*WakeOnPattern" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "AutoPowerSaveModeEnabled" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*DeviceSleepOnDisconnect" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EEELinkAdvertisement" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EEELinkAdvertisement" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EeePhyEnable" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EeePhyEnable" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableGreenEthernet" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableModernStandby" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableModernStandby" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "GigaLite" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "GigaLite" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PnPCapabilities" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PnPCapabilities" /t REG_DWORD /d "24" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerDownPll" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PowerDownPll" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerSavingMode" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ReduceSpeedOnPowerDown" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "S5WakeOnLan" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "S5WakeOnLan" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "SavePowerNowEnabled" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "SavePowerNowEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ULPMode" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ULPMode" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnLink" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnLink" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnSlot" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnSlot" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeUpModeCap" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeUpModeCap" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WaitAutoNegComplete" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WaitAutoNegComplete" /t REG_SZ /d "0" /f
    )
    for /f %%i in ('reg query "%%a" /v "*FlowControl" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*FlowControl" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WolShutdownLinkSpeed" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnMagicPacketFromS5" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnMagicPacketFromS5" /t REG_SZ /d "2" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WolShutdownLinkSpeed" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PMNSOffload" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*PMNSOffload" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PMARPOffload" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*PMARPOffload" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*NicAutoPowerSaver" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*NicAutoPowerSaver" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PMWiFiRekeyOffload" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*PMWiFiRekeyOffload" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePowerManagement" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnablePowerManagement" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ForceWakeFromMagicPacketOnModernStandby" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ForceWakeFromMagicPacketOnModernStandby" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeFromS5" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeFromS5" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOn" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOn" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "OBFFEnabled" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "OBFFEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "DMACoalescing" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "DMACoalescing" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableSavePowerNow" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableSavePowerNow" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableD0PHYFlexibleSpeed" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableD0PHYFlexibleSpeed" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePHYWakeUp" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnablePHYWakeUp" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePHYFlexibleSpeed" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnablePHYFlexibleSpeed" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "AllowAllSpeedsLPLU" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "AllowAllSpeedsLPLU" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*EnableDynamicPowerGating" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*EnableDynamicPowerGating" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableD3ColdInS0" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableD3ColdInS0" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "LatencyToleranceReporting" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "LatencyToleranceReporting" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableAspm" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableAspm" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "LTROBFF" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "LTROBFF" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "S0MgcPkt" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "S0MgcPkt" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TCPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TCPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPConnectionOffloadIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TCPConnectionOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPConnectionOffloadIPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TCPConnectionOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPUDPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TCPUDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPUDPChecksumOffloadIPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TCPUDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*UDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*UDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UdpRsc" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*UdpRsc" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "**UsoIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*UsoIPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UsoIPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*UsoIPv6" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*RscIPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*RscIPv6" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*RscIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*RscIPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*IPsecOffloadV2IPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*IPsecOffloadV2IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*IPsecOffloadV2" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*IPsecOffloadV2" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*IPsecOffloadV1IPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*IPsecOffloadV1IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*LsoV1IPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*LsoV1IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*LsoV2IPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*LsoV2IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*LsoV2IPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*LsoV2IPv6" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*IPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*IPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeFromPowerOff" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeFromPowerOff" /t REG_SZ /d "0" /f >nul 2>&1
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
powershell disable-netadapterbinding -name "*" -componentid vmware_bridge, ms_lldp, ms_lltdio, ms_implat, ms_rspndr, ms_server, ms_msclient >nul 2>&1
netsh int tcp set security profiles=disabled >nul 2>&1
netsh int udp set global uro=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
cls
exit