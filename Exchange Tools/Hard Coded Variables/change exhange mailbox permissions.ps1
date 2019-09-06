#Add Access to Mailboxes on exchange.

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
$user_access = "AD username here"

#Set Mailbox Automapping
$automap = "$true"

#Pulls in a text file of mailboxe, creates a useable PSobject
#Uses AD username to Identify the mailboxes.
$txt = "C:\temp\users.txt"
$mailboxes = Get-Content $txt

#Adds full access to "user_access" to each of the mailboxboxes listed in the text file.
foreach( $mailbox in $mailboxes){
Add-MailboxPermission -Identity $mailbox -User $user_access -AccessRights Fullaccess -InheritanceType all -Automapping $automap
}


####
#Adds full access permission to "oneadmin" to the mailbox of "martin"
#Add-MailboxPermission -Identity martin -User 'oneadmin' -AccessRight FullAccess -InheritanceType All -Automapping $false
