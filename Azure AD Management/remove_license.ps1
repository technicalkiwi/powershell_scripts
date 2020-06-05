#$AzureAdCred = Get-Credential
#Connect-AzureAD -Credential $AzureAdCred

# Sets the Various Licenses
$OfficePlan = "OFFICESUBSCRIPTION"
$E3Plan = "ENTERPRISEPACK"
$PremiumOFFICEPLAN = "O365_BUSINESS_PREMIUM"
$TeamsPlan = "TEAMS_COMMERCIAL_TRIAL"


# Set the License to remove
$License = $TeamsPlan

$UserPrincipals = Get-AzureADUser -all $true | Select-Object userprincipalname
#$UserPrincipals = "Kelly.Galbraith@briscoegroup.co.nz", "nick.turner@briscoegroup.co.nz"

foreach($UserPrincipal in $UserPrincipals.userprincipalname){

$UserPrincipal    
# Remove Licence
    # Get SkuID for Office License
    $RemovedLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $RemovedLicense.SkuId = (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $License -EQ).SkuID
    
    # Create Object for Licence Removal
    $LicensesToRemove = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $LicensesToRemove.AddLicenses = @()
    $LicensesToRemove.RemoveLicenses = $RemovedLicense.SkuId
    
    # Set Licence Removal to User
    Set-AzureADUserLicense -ObjectId $UserPrincipal -AssignedLicenses $LicensesToRemove

}
   