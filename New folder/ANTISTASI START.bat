@echo off
chdir /d "C:\arma3\scripts"
COLOR 0B
TITLE Arma 3 server auto restarter
SETLOCAL EnableExtensions enabledelayedexpansion
set EXE=arma3server.exe
set EXE2=

goto CheckServerRunning

:CheckServerRunning
cls
echo "Checking arma 3 server status (Please Wait)."
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto KillRestartServer
goto StartArma3Server

:StartArma3Server
cls
echo "Starting arma 3 server (Please Wait)."
timeout 5 >nul
call "Antistasi - 03 - Antistasi.bat"
goto LastServerCheck

:KillRestartServer
cls
echo "Killing and Updating Arma 3 Server (Please Wait)."
timeout 5 >nul
taskkill /F /IM %EXE% >nul
timeout 20 >nul
cls
goto CheckServerRunning


:LastServerCheck
cls
echo "Checking arma 3 server Is Running (Please Wait)."
timeout 20 >nul
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto ExitConfig
goto StartArma3Server

:ExitConfig
cls
echo "Arma 3 Server Is Running (exiting).
timeout 10 >nul
exit