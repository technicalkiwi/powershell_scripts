$AzureAdCred = Get-Credential
Connect-AzureAD -Credential $AzureAdCred


Set-MsolUserLicense -UserPrincipalName "belindan@litwareinc.com" -AddLicenses "litwareinc:ENTERPRISEPACK"
