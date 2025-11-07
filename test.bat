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