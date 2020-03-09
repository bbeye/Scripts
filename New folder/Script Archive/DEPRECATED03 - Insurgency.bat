@echo off
setlocal enableDelayedExpansion

REM ==========  What should I be named?  ==========
REM =======  ( Same as config file names )  =======
SET launchID=Insurgency


REM =========  Where is ArmA installed?  ==========
SET armaPath=C:\arma3\servers\insurgency\


REM =======  Where are the mods installed?  =======
SET repoPath=C:\arma3\steam\steamapps\workshop\content\107410\


REM ======  What server addons do you want?  ======
SET serverMods=@asm;@AdvancedTowing;@AdvancedSlingloading;@DisableBI
SET headlessMods=@asm


REM =========  Where do I save the logs?  =========
SET profileData=C:\arma3\profiles\insurgency\


REM ===========  Where are my configs?  ===========
SET configData=C:\arma3\configs\insurgency\


REM =============  Where is BattlEye?  ============
SET bePath=C:\arma3\servers\insurgency\BattlEye\


REM =============  What port am I on?  ============
SET port=2302
		

REM ========  How many headless clients ?  ========
SET headlessCount=1

REM ====  How many headless client password ?  ====
SET headlessConnect=horsehockey


REM ===========  Performance Modifiers  ===========
SET processType=/realtime /affinity FF
SET serverAdditional=-netlog -enableHT -filePatching -autoInit


REM /---------------------------------------------\
REM |                                             |
REM |                  STOP HERE                  |
REM |                                             |
REM |       DO NOT EDIT BENEATH THIS BLOCK        |
REM |                                             |
REM \---------------------------------------------/


SET armaMods=
SET hcMods=


PUSHD %ARMAPATH%

FOR %%a IN ("%serverMods:;=" "%") DO (
	IF %%a NEQ "" (
		CALL :c 06 "Loading Server Mod	"
		IF EXIST "%%~a" (
			CALL :c 0a "%%~a" /n
			SET "armaMods=!armaMods!%%~a;"
		) ELSE (
			CALL :c 04 "%%~a" /n
		)
	)
)

FOR %%a IN ("%headlessMods:;=" "%") DO (
	IF %%a NEQ "" (
		CALL :c 06 "Loading Headless Mod	"
		IF EXIST "%%~a" (
			CALL :c 0a "%%~a" /n
			SET "hcMods=!hcMods!%%~a;"
		) ELSE (
			CALL :c 04 "%%~a" /n
		)
	)
)
 
POPD


PUSHD %repoPath%

FOR /F "usebackq tokens=1* delims==>" %%I IN ("\arma3\configs\modlist.txt") DO (
    SET "modlist[%%~I]=%%~J"
)

FOR /F "tokens=2* delims=[]=" %%A IN ('SET modlist') DO (
	IF %%~A NEQ "" (
		CALL :c 06 "Loading Repo Mod	"
		IF EXIST "%%~B" (
			CALL :c 0a "%%~B	[ %%~A ]" /n
			SET "armaMods=!armaMods!%repoPath%%%~B;"
			SET "hcMods=!hcMods!%repoPath%%%~B;"
		) ELSE (
			CALL :c 04 "%%~B	[ %%~A ]" /n
		)
	)
)

POPD


echo:
echo:


CHOICE /M "Continue Load?" /D Y /T 10


echo:
echo:
echo:


IF %ERRORLEVEL% == 1 (
	CALL :c 0E "Starting "
	CALL :c 0A %launchID%
	CALL :c 0E " Server" /n

	start "%LAUNCHID%" %PROCESSTYPE% "%ARMAPATH%arma3server.exe" -port=%PORT% "-config=%CONFIGDATA%%LAUNCHID%_server.cfg" "-cfg=%CONFIGDATA%%LAUNCHID%_basic.cfg" "-profiles=%PROFILEDATA%" -name=%LAUNCHID% -filePatching "-mod=%ARMAMODS%" -autoInit -enableHT

	timeout 20
	
	echo:
	
	CALL :c 0E "Starting "
	CALL :c 0A %launchID%
	CALL :c 0E " Headless Client #{x}" /n
	
	start /min "%LAUNCHID%" %PROCESSTYPE% "%ARMAPATH%arma3server.exe" -client -connect=127.0.0.1 -port=%PORT% -password=%HEADLESSCONNECT% "-profiles=%PROFILEDATA%" -name=%LAUNCHID%-HC1 "-mod=%HCMODS%"
	
	timeout 20
	
	echo:
	
	) ELSE (
		ECHO "EXITING LAUNCH BAY"
		ECHO:
		exit /b
)

echo:
echo:

ECHO All servers have started

echo:
echo:

exit /b

:c
setlocal enableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
:: The single blank line within the following IN() clause is critical - DO NOT REMOVE
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b


:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b


:cleanupColorPrint
2>nul del "%temp%\'"
2>nul del "%temp%\colorPrint.txt"
>nul subst ': /d
exit /b