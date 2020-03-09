$server1 = Read-Host "Server 1"
$server2 = Read-Host "Server 2"

$server1Patches = get-hotfix -computer $server1 | Where-Object {$_.HotFixID -ne "File 1"}

$server2Patches = get-hotfix -computer $server2 | Where-Object {$_.HotFixID -ne "File 1"}

Compare-Object ($server1Patches) ($server2Patches) -Property HotFixID