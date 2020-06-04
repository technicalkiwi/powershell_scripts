$AzureAdCred = Get-Credential
Connect-AzureAD -Credential $AzureAdCred

$OldOfficePlan = "OFFICESUBSCRIPTION"
$OldE3Plan = "ENTERPRISEPACK"
$OFFICEPLAN = "O365_BUSINESS_PREMIUM"

#$TEAMSPLAN = "TEAMS_COMMERCIAL_TRIAL"

#$UserPrincipals = Get-AzureADUser -all $true | Select-Object userprincipalname
$UserPrincipals = "adrian.limpin@briscoegroup.co.nz", "blair.cochrane@briscoegroup.onmicrosoft.com ", "Chris.Huang@briscoegroup.onmicrosoft.com ", "Krystal.moon@briscoegroup.onmicrosoft.com ", "russell.black@briscoegroup.co.nz", "stuartg@briscoegroup.co.nz" 

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

#Remove Office E3 Licence
    # Get SkuID for E3 Office License
    $OldE3OfficeLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $OldE3OfficeLicense.SkuId = (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $OLDE3PLAN -EQ).SkuID
    
    # Create Object for Office Licence 
    $OfficeE3LicensesToRemove = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $OfficeE3LicensesToRemove.AddLicenses = @()
    $OfficeE3LicensesToRemove.RemoveLicenses = $OldE3OfficeLicense.SkuId
    
    # Assign Office Licence to User
    Set-AzureADUserLicense -ObjectId $UserPrincipal -AssignedLicenses $OfficeE3LicensesToRemove


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
   