@echo Create Desktop Shortcut to Evolve Folder
powershell -Command ^
"$shell = New-Object -ComObject WScript.Shell; ^
$shortcut = $shell.CreateShortcut('%USERPROFILE%\Desktop\Evolve.lnk'); ^
$shortcut.TargetPath = 'C:\Windows\Evolve'; ^
$shortcut.IconLocation = 'C:\Windows\System32\imageres.dll,3'; ^
$shortcut.Save()"