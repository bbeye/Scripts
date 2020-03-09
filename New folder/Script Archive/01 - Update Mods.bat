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
	c:\arma3\steam\steamcmd.exe +login 100dollarrandy +workshop_download_item 107410 %%B validate +quit  
	ECHO -----------------------------------
	)
)

FOR /F "tokens=2* delims=[]=" %%A IN ('SET whitelist') DO (
	ECHO Downloading Whitelist Mod %%B [ %%A ]
	>> "C:\arma3\scripts\Update Logs\ModUpdate_%backupFilename%.log" (
	ECHO Downloading Whitelist Mod %%B [ %%A ]
	ECHO -----------------------------------
	c:\arma3\steam\steamcmd.exe +login 100dollarrandy +workshop_download_item 107410 %%B validate +quit
	ECHO -----------------------------------
	)
)
