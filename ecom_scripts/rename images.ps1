#set some variables
$txtfile = "C:\TEMP\missing_pic.txt"
$imageSkus = Get-Content $txtfile
#$missingitems = "one off item"
$mainDirectory = "\\xxxxxxxxxxxxxxxxxxxx"
$main_modelDirectory = "xxxxxxxxxxxxxx"
$altDirectory = "xxxxxxxxxxxxxx"
$Alt_modelDirectory = "xxxxxxxxxxxxxx"


#FOR MAIN FOLDER
$MainImages = Get-ChildItem $mainDirectory

foreach ($ItemSku in $ItemSkus){

$Image = $MainImages | Where{$_.Name -Match "$ItemSku"}

if ($image.count -eq "1") {
    $image | Rename-Item -NewName $itensku_prod
    
}

#search through for images
foreach($imageSku in $imageSkus){
$item
$pics = $folders | Where{$_.Name -Match "$item" }



}