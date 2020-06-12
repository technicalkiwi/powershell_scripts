#$AzureAdCred = Get-Credential
#Connect-AzureAD -Credential $AzureAdCred

$OfficePremiumPlan = "O365_BUSINESS_PREMIUM"
$E3OFFICEPLAN = "ENTERPRISEPACK"

#$TEAMSPLAN = "TEAMS_COMMERCIAL_TRIAL"

$UserPrincipals = Get-Content C:\temp\e3.txt
#$UserPrincipals = Get-AzureADUser -all $true | Select-Object userprincipalname
#$UserPrincipals = "Kelly.Galbraith@briscoegroup.co.nz", "nick.turner@briscoegroup.co.nz"

foreach($UserPrincipal in $UserPrincipals){ #.userprincipalname){

$UserPrincipal    
# Remove Old Office Licence
    # Get SkuID for Office License
    $OldOfficeLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $OldOfficeLicense.SkuId = (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $OLDOFFICEPLAN -EQ).SkuID
    
    # Create Object for Office Licence 
    $OfficeLicensesToRemove = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $OfficeLicensesToRemove.AddLicenses = @()
    $OfficeLicensesToRemove.RemoveLicenses = $OldOfficeLicense.SkuId
    
    # Assign Office Licence to User
    Set-AzureADUserLicense -ObjectId $UserPrincipal -AssignedLicenses $OfficeLicensesToRemove

# Assign Office Licence
    # Get SkuID for Office License
    $OfficeLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $OfficeLicense.SkuId = (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $OFFICEPLAN -EQ).SkuID
    
    # Create Object for Office Licence 
    $OfficeLicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $OfficeLicensesToAssign.AddLicenses = $OfficeLicense
    
    # Assign Office Licence to User
    Set-AzureADUserLicense -ObjectId $UserPrincipal -AssignedLicenses $OfficeLicensesToAssign
   
}
   