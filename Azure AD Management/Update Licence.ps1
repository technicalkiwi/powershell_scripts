


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