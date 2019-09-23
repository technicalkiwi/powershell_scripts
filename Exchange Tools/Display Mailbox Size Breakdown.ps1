# Tool to Display a breakdown of a users mailbox and where the space is being used.

#Sets some Hard Coded Variables
$No = "n", "N", "No", "NO"
$Yes = "y", ",Y", "Yes", "YES"

#pop up box to ask for credential (use bgr account)
Write-Host " Use Your BGR Account for the pop up"
$cred = get-credential
#pulls in the commands from exchange server, and starts a remote session
$Session = New-PSSession -configurationname Microsoft.Exchange -connectionURI http://exchange2k10/Powershell -credential $cred

#Imports the Exhange command set from the remote server
Import-PSSession $Session -DisableNameChecking

#Set Which users mailbox to search
$Global:User = Read-Host "Enter Username of mailbox"

#runs through the users mailbox and exports a break down of where the space is being used.
$mailbox = Get-MailboxFolderStatistics  -Identity briscoes\$user
$folders= ($mailbox | Select-Object Name,FolderPath,FolderSize,FolderAndSubfolderSize )
$folders | Sort-Object folderpath

$Global:export = Read-Host "Do you wish to export the break down?"
#Exports the breakdown into a txt file.
if($Yes -contains $export){
$user | Out-File "c:\temp\$user mailbox.txt" -Append
$folders | Out-File "c:\temp\$user mailbox.txt" -Append
}

