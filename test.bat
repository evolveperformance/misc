@echo off
echo Downloading Evolve background wallpaper...
set "BG_IMAGE=%TEMP%\EvolveBackground.jpg"
curl.exe -L "https://raw.githubusercontent.com/evolveperformance/misc/main/background.png" -o "%BG_IMAGE%"

if not exist "%BG_IMAGE%" (
    echo [!] Background download failed. Skipping wallpaper setup.
    goto skipwallpaper
)

echo Installing background to Windows directories...
copy /Y "%BG_IMAGE%" "C:\Windows\Web\Wallpaper\EvolveBackground.jpg" >nul 2>&1
copy /Y "%BG_IMAGE%" "C:\Windows\Web\Screen\EvolveBackground.jpg" >nul 2>&1

echo Background installed successfully.
del "%BG_IMAGE%" >nul 2>&1

echo Setting Evolve wallpaper...
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Windows\Web\Wallpaper\EvolveBackground.jpg" /f
reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 10 /f
powershell -Command "$code = '[DllImport(\"user32.dll\", CharSet=CharSet.Auto)]public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);'; $type = Add-Type -MemberDefinition $code -Name WallpaperUtil -Namespace Win32 -PassThru; $type::SystemParametersInfo(0x0014, 0, 'C:\Windows\Web\Wallpaper\EvolveBackground.jpg', 0x03)"

echo Wallpaper applied successfully.

:skipwallpaper
