<#  
.SYNOPSIS  
    Example goes Here
    
.DESCRIPTION  
    Multi Line Description
    Can Go Here

.LINK 
Links can go here
    
.INPUTS
  Inputs prompts are located within script.
  
.OUTPUTS
  Log file stored in $CurrentDir\Log.txt>
  
.NOTES
  Version:        2,0
  Author:         ME
  Creation Date:  10/06/2016
  Purpose/Change: 
  
.EXAMPLE
  Execute in Admin Powershell and enter Prompts.

#>

# this will begin logging
$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path $LoggingPath -append

# this will run PS as admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}








# this will end the logging
Stop-Transcript