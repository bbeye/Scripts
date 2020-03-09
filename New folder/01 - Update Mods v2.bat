@echo off
setlocal
set backupFilename=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

for /f "usebackq tokens=1* delims==>" %%I in ("\arma3\configs\modlist.txt") do (
    set "modlist[%%~I]=%%~J"
)

set modlist

for /f "usebackq tokens=1* delims==>" %%I in ("\arma3\configs\whitelist.txt") do (
    set "whitelist[%%~I]=%%~J"
)

set whitelist

FOR /F "tokens=2* delims=[]=" %%A IN ('SET modlist') DO (
	ECHO Downloading Mod %%B [ %%A ]
	>> "C:\arma3\scripts\Update Logs\ModUpdate_%backupFilename%.log" (
	ECHO Downloading Mod %%B [ %%A ]
	ECHO -----------------------------------
	"C:\Program Files (x86)\steamcmd\steamcmd.exe" +login 100dollarrandy +"workshop_download_item 107410 %%B" validate +quit  
	xcopy "C:\Program Files (x86)\steamcmd\steamapps\workshop\content\107410\%%B" "C:\arma3\steam\steamapps\workshop\content\107410\%%B" /s/h/e/k/f/c/i/y
	ECHO -----------------------------------
	)
)

FOR /F "tokens=2* delims=[]=" %%A IN ('SET whitelist') DO (
	ECHO Downloading Whitelist Mod %%B [ %%A ]
	>> "C:\arma3\scripts\Update Logs\ModUpdate_%backupFilename%.log" (
	ECHO Downloading Whitelist Mod %%B [ %%A ]
	ECHO -----------------------------------
	"C:\Program Files (x86)\steamcmd\steamcmd.exe" +login 100dollarrandy +"workshop_download_item 107410 %%A" validate +quit  
	xcopy "C:\Program Files (x86)\steamcmd\steamapps\workshop\content\107410\%%A" "C:\arma3\steam\steamapps\workshop\content\107410\%%A" /s/h/e/k/f/c/i/y
	ECHO -----------------------------------
	)
)
