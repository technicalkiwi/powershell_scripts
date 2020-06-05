$Allskus = Get-AzureADSubscribedSku 
$Allskus  | Select -Property Sku*,ConsumedUnits -ExpandProperty PrepaidUnits

$Allskus | Select-Object SkuPartNumber