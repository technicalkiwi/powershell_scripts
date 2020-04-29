$AzureAdCred = Get-Credential
Connect-AzureAD -Credential $AzureAdCred

$No = "n", "N", "No", "NO"
$Yes = "y", ",Y", "Yes", "YES"

$OFFICEPLAN = "ENTERPRISEPACK"
$TEAMSPLAN = "TEAMS_COMMERCIAL_TRIAL"

"#### USER SETUP SECTION"
""
$Firstname = Read-Host -Prompt "Please Enter First Name:  "
$Lastname = Read-Host -Prompt "Please Enter Last Name:  "
$Password = Read-Host -Prompt "Please Enter Initial Passoword:  "
""
""
#Setup Licences to attach to the account
"#### LICENCE SECTION ####"
""
$OfficeInstall = Read-Host -Prompt "Assign Office Licence  (Y/N)  "
$TeamsInstall = Read-Host -Prompt "Assign Office Licence  (Y/N)  "

# Create Objects to feed to User Creation
$Displayname = $Firstname + " " + $Lastname
$UserPrincipal = $Firstname + "." + $Lastname + "@briscoegroup.co.nz"

# Setup Password object for User Creation
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = $Password

# Create New Azure AD User
New-AzureADUser -DisplayName $Displayname -PasswordProfile $PasswordProfile -UserPrincipalName $UserPrincipal -AccountEnabled $true -MailNickName $Firstname

# Assign Office Licence if Required
if($yes -contains $OfficeInstall){
# Get SkuID for Office License
$OfficeLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$OfficeLicense.SkuId = (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $OFFICEPLAN -EQ).SkuID

# Create Object for Office Licence 
$OfficeLicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
$OfficeLicensesToAssign.AddLicenses = $OfficeLicense

# Assign Office Licence to User
Set-AzureADUserLicense -ObjectId $UserPrincipal -AssignedLicenses $OfficeLicensesToAssign
}

# Assign Teams Licence if Required
if($yes -contains $TeamsInstall){

# Get SkuID for Teams Licence
$TeamsLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$TeamsLicense.SkuId = (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $TEAMSPLAN -EQ).SkuID

# Create Object for Teams Licence
$TeamsLicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
$TeamsLicensesToAssign.AddLicenses = $TeamsLicense

# Assign Teams Licence to User
Set-AzureADUserLicense -ObjectId $UserPrincipal -AssignedLicenses $TeamsLicensesToAssign
}