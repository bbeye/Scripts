@echo off
setlocal enabledelayedexpansion
goto :GetModNumber

:GetModNumber
setlocal enabledelayedexpansion

set /p id="Enter SteamID for Mod: "
set /P modname="Please enter the name of the mod: "


call :ModRequest %id%
echo.
echo Press enter to open folder and verify files
echo.
Pause
echo.
start C:\arma3\steam\steamapps\workshop\content\107410\%id%
echo.
set /P answer="Everything look good? Y/N "
if /i "%answer%" EQU "N" (
	goto :GetModNumber
)


set /P answer2="Do you want to add this mod to the modlist? Y/N "
if /i "%answer2%" EQU "y" (
	echo.
	echo Adding %modname% to modlist.
	echo %modname%=%id% >> C:\arma3\configs\modlist.txt
	notepad.exe "C:\arma3\configs\modlist.txt"
echo The new mod should be at the bottom of the list.
pause
) else (
	quit
	)



goto :eof
quit

:ModRequest

setlocal enabledelayedexpansion
"C:\Program Files (x86)\steamcmd\steamcmd.exe" +login 100dollarrandy +"workshop_download_item 107410 %~1" validate +quit
echo.
pause
xcopy "C:\Program Files (x86)\steamcmd\steamapps\workshop\content\107410\%id%" "C:\arma3\steam\steamapps\workshop\content\107410\%id%" /s/h/e/k/f/c/i/y
echo.
goto :eof
