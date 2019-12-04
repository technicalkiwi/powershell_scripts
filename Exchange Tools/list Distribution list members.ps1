### Script to remove all inactive users from distibution groups

#Set some variables
$LogPath = 'C:\TEMP\log\dist-groups.txt'
$URI = 'http://exchange2k10/Powershell'

#Create the log file
Add-Content $LogPath "DISTRUBTION GROUP MEMBERSHIP"

# Connects to the exchange server and imports a session
#pop up box to ask for credential (use bgr account)
Write-Host " Use Your BGR Account for the pop up"
$cred = get-credential
#pulls in the commands from exchange server, and starts a remote session
$Session = New-PSSession -configurationname Microsoft.Exchange -connectionURI $URI -credential $cred

#Imports the Exhange command set from the remote server
Import-PSSession $Session -DisableNameChecking

####pulls in a list of all distibution groups
#$distgroups = Get-DistributionGroup 
$inputdistgroup = Read-Host -Prompt "Enter Distribution group name"
$distgroup = Get-DistributionGroup | Where-Object name -like $inputdistgroup

$DistGroupMembers = Get-DistributionGroupMember -Identity $distgroup.name
$DistGroupMembers.name | Sort-Object
