

$BusinessPremium = "f245ecc8-75af-4f8e-b61f-27d8114de5f3"
$E3Plan = '6fd2c87f-b296-42f0-b197-1e91e994b900'

$Users = Get-AzureADUser | Where-Object Department -eq $Label

foreach($user in $users){
$licenseSKu = $user.AssignedLicenses.skuid

if($licenseSKu -eq $BusinessPremium) {     

$StandardLicense = Get-AzureADSubscribedSku | Where-Object {$_.SkuId -eq $BusinessPremium}

    $SkuFeaturesToEnable = @("OFFICE_BUSINESS","EXCHANGE_S_STANDARD","SHAREPOINTSTANDARD")
    $SkuFeaturesToDisable = $StandardLicense.ServicePlans | ForEach-Object { $_ | Where-Object {$_.ServicePlanName -notin $SkuFeaturesToEnable }}

    $License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $License.SkuId = $StandardLicense.SkuId
    $License.DisabledPlans = $SkuFeaturesToDisable.ServicePlanId

    $LicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $LicensesToAssign.AddLicenses = $License

Set-AzureADUserLicense -ObjectId $User.ObjectId -AssignedLicenses $LicensesToAssign

}elseif($licenseSKu -eq $E3Plan){

    $E3License = Get-AzureADSubscribedSku | Where-Object {$_.SkuId -eq $E3Plan}
        $SkuFeaturesToEnable = @("OFFICE_BUSINESS","EXCHANGE_S_STANDARD","SHAREPOINTSTANDARD")
        $SkuFeaturesToDisable = $E3License.ServicePlans | ForEach-Object { $_ | Where-Object {$_.ServicePlanName -notin $SkuFeaturesToEnable }}
        
        $License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
        $License.SkuId = $E3License.SkuId
        $License.DisabledPlans = $SkuFeaturesToDisable.ServicePlanId
        
        $LicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
        $LicensesToAssign.AddLicenses = $License

        Set-AzureADUserLicense -ObjectId $User.ObjectId -AssignedLicenses $LicensesToAssign
    }
}else{"License not found for $User"}