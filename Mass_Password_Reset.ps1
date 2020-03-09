# Specify the OU.

#Replace with OU Structure for Sub Folder
#Eg: OU=Test,OU=Clients,DC=example,DC=lan with OU=mnemonic,OU=Clients,DC=example,DC=lan
$OU = [ADSI]"LDAP://OU=Test,OU=Clients,DC=example,DC=lan"

#Enter Password Here.
#Special Characters must be escaped such as $,#,",' with a `
$Password = "Pa$$w0rd"

# Enumerate all objects in the OU.
$arrChildren = $OU.Get_Children()
ForEach ($User In $arrChildren)
{
    # Only consider user objects.
    If ($User.Class -eq "user")
    {
		Write-Host 'Changing Password for: ' $User.DisplayName '---' $User.SAMAccountName
        # Set password.
        $User.Invoke("SetPassword", $Password)
        # Expire the password.
        $User.pwdLastSet = 0
        $User.SetInfo()
    }
}