@echo off
setlocal
echo This Will Install/Update Stable Arma3
echo

c:\arma3\steam\steamcmd.exe +login 100dollarrandy +force_install_dir C:\arma3\servers\insurgency +app_update 233780 validate +quit
echo ----------------------------------------
echo Arma 3 Installed/Updated !
echo ----------------------------------------
pause