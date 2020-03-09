@ECHO OFF
SETLOCAL enableDelayedExpansion

SET "repoPath=C:\arma3\steam\steamapps\workshop\content\107410\"
SET "keyPath=C:\arma3\servers\insurgency\keys\"

for /R "%repoPath%" %%i in (*.bikey) do xcopy /Y "%%i" "%keyPath%"

pause
