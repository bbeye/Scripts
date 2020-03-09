@ECHO OFF
SETLOCAL enableDelayedExpansion

SET "repoPath=C:\arma3\steam\steamapps\workshop\content\107410\"
SET "keyPath=C:\arma3\servers\insurgency\keys\"

REM for /R "%keyPath%" %%i in (*.bikey) do if not "%%i"=="a3.bikey" del /q "%%i"


for /R "%repoPath%" %%i in (*.bikey) do xcopy /Y "%%i" "%keyPath%"


pause