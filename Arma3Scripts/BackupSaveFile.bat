@echo off
setlocal enabledelayedexpansion



C:\arma3\profiles\persistence\Users\persistence\backups\


set /p backupverification="This will backup to the most recent save file, proceed? Y/N"

if /i "%backupverification%" EQU "N" (

	goto :exit

) if /i "%backupverification" EQU "Y" (

  call :runbackup
  set /p workingtest="Did that work?"
    if /i "%workingtest%" EQU "Y" (
	     goto :exit
    ) if /i "%workingtest%" EQU "N" (
       call :runbackup
       )

)

:runbackup
for /f %%i in ('dir Persistence.vars.Arma3Profile* /b/a-d/od/t:c') do set LAST=%%i
echo OK, I am going to use the following backup file: %LAST%

echo Press a key to continue...
pause

//This renames the current save file
copy %LAST% *.used
ren C:\arma3\profiles\persistence\users\persistence\Persistence.vars.Arma3Profile *.used
copy %LAST% C:\arma3\profiles\persistence\users\persistence\Persistence.vars.Arma3Profile


call "PERSISTENT START NO BACKUP.bat"
echo Restarting the server, please verify the success
:eof


:exit
quit
:eof
