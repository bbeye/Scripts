rem @echo off
setlocal enabledelayedexpansion
goto :verify

:verify
setlocal enabledelayedexpansion
set /p backupverification="This will backup to the most recent save file, proceed? Y/N "
pause

if /i "%backupverification%" EQU "N" (
	echo No
	pause
	goto :exit

) 
  goto :runbackup
  pause
  set /p workingtest="Did that work? (Y/N)"
    if /i "%workingtest%" EQU "Y" (
	     goto :exit
    ) if /i "%workingtest%" EQU "N" (
		echo OK Running it again
		Timeout 5
       goto :runbackup
       )
	goto :eof
	
:runbackup
setlocal enabledelayedexpansion
for /f %%i in ('dir C:\arma3\profiles\persistence\users\persistence\backups\Persistence.vars.Arma3Profile.* /b/a-d/od/t:c') do set LAST=%%i
echo OK, I am going to use the following backup file: %LAST%

echo Press a key to continue...
pause

rem This copies the current backup save file in case shit goes really bad
copy C:\arma3\profiles\persistence\Users\persistence\backups\%LAST% .\*.used

pause

rem then renames the active save file
del C:\arma3\profiles\persistence\Users\persistence\Persistence.vars.used
ren C:\arma3\profiles\persistence\users\persistence\Persistence.vars.Arma3Profile *.used
rem then copies the backup save to active folder:
copy C:\arma3\profiles\persistence\Users\persistence\backups\%LAST% C:\arma3\profiles\persistence\users\persistence\Persistence.vars.Arma3Profile
rem then moves the backup folder into the no good, so when this cycle repeats it will not be used again
move /Y C:\arma3\profiles\persistence\Users\persistence\backups\%LAST% "C:\arma3\profiles\persistence\Users\persistence\backups\no good\%LAST%"

pause

call "C:\Users\Administrator\Desktop\PERSISTENT START NO BACKUP.bat"
echo Restarting the server, please verify the success
pause

goto :eof


:exit
rem quit
goto :eof
