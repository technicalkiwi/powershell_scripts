
$AzureAdCred = Get-Credential
Connect-AzureAD -Credential $AzureAdCred

$No = "n", "N", "No", "NO"
$Yes = "y", ",Y", "Yes", "YES"

$OFFICEPLAN = "OFFICESUBSCRIPTION"
$TEAMSPLAN = "TEAMS_COMMERCIAL_TRIAL"
$Location = "NZ"

$csvpath = "C:\Users\Aaron\Documents\AzureAD_Users_Upload.csv"
$NewAzureAdUsers = Import-Csv -Path $csvpath

foreach ($NewAzureAdUser in $NewAzureAdUsers){
$firstname = $NewAzureAdUser.firstname
$lastname = $NewAzureAdUser.lastname
$Username = $NewAzureAdUser.username
$UserPrincipal = $Username + "@briscoegroup.co.nz"
$Password = $NewAzureAdUser.password


# Create Objects to feed to User Creation
$Displayname = $Firstname + " " + $Lastname

# Setup Password object for User Creation
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = $Password
$PasswordProfile.EnforceChangePasswordPolicy = $false

# Create New Azure AD User
New-AzureADUser -DisplayName $Displayname -PasswordProfile $PasswordProfile -UserPrincipalName $UserPrincipal -AccountEnabled $true -MailNickName $username
Set-AzureADUser -ObjectID $UserPrincipal -UsageLocation $Location
}