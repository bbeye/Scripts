ECHO off
REM Profile 1 is the second profile for me, Default would refer to my personal account
start chrome --profile-directory="Profile 1" "https://sites.google.com/a/ixl.com/hub/general-interest?authuser=3" "https://mail.google.com/mail/u/0/?tab=cm#inbox" "https://ixl.my.salesforce.com/console" "https://ixl.slack.com/threads/team/UEJ4WJ83F/"

REM This is just my local. Don't think connection can be automated.
cd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Palo Alto Networks\GlobalProtect"
start globalprotect
exit