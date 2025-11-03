@echo Windows HWID Activation (Silent)
echo Set WshShell = CreateObject("WScript.Shell") > "%TEMP%\activate.vbs"
echo WshShell.Run "powershell.exe -ExecutionPolicy Bypass -Command ""& ([ScriptBlock]::Create((irm https://get.activated.win))) /HWID""", 0, True >> "%TEMP%\activate.vbs"
cscript //nologo "%TEMP%\activate.vbs"
del "%TEMP%\activate.vbs" >nul 2>&1