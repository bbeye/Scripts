@echo off
setlocal enabledelayedexpansion

set backupFilename="%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%_%time:~0,2%%time:~3,2%"

copy C:\arma3\profiles\persistence\Users\persistence\Persistence.vars.Arma3Profile C:\arma3\profiles\persistence\Users\persistence\backups\Persistence.vars.Arma3Profile.%backupFilename%

