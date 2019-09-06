#Add Access to Mailboxes on exchange.

#Sets some Hard Coded Variables
$No = "n", "N", "No", "NO"
$Yes = "y", ",Y", "Yes", "YES"

#Pops up a login gui asking for credentials, used to connect to the exchange server
$cred = get-credential

#Initiates a remote session connection to the exhange server
#Change connectionURI to exchange Server name or IP Address
$Session = New-PSSession -configurationname Microsoft.Exchange -connectionURI http://exchange2k10/Powershell -credential $cred

#Imports the Exhange command set from the remote server
Import-PSSession $Session -DisableNameChecking

#Execute commands from here down on the Exchange Server
#----------------------------------

#Sets the user that will be given permissions
$Global:User_access = Read-Host "Enter user being granted access"

#Sets the mailbox to give permissions on
$Global:mailbox = Read-Host "Enter mailbox the user is being granted access to"

#Set Mailbox Automapping
$Global:Automapping = Read-Host "Do you wish to Set Automapping (Y/N)"
If($No -contains $Automapping){
    $automap = $false
}else{ $automap = $true }

#Adds full access to user specified to the mailbox listed
Add-MailboxPermission -Identity $mailbox -User $user_access -AccessRights Fullaccess -InheritanceType all -Automapping $automap


####
#Adds full access permission to "oneadmin" to the mailbox of "martin"
#Add-MailboxPermission -Identity martin -User 'oneadmin' -AccessRight FullAccess -InheritanceType All -Automapping $false
